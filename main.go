package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

// Style definitions
var (
	brandStyle  = lipgloss.NewStyle().Foreground(lipgloss.Color("#F6AA1C")).Bold(true)
	tealStyle   = lipgloss.NewStyle().Foreground(lipgloss.Color("#1B998B")).Bold(true)
	dimStyle    = lipgloss.NewStyle().Foreground(lipgloss.Color("#6B7280")).Faint(true)
	answerStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("#83C5BE"))
	borderStyle = lipgloss.NewStyle().BorderStyle(lipgloss.RoundedBorder()).BorderForeground(lipgloss.Color("#1B998B"))
)

// Model represents an AI model
type AIModel struct {
	ID       string
	Name     string
	Endpoint string
}

// Supported models
var models = []AIModel{
	{"gpt-5.5", "GPT 5.5", "https://opencode.ai/zen/v1/responses"},
	{"gpt-5", "GPT 5", "https://opencode.ai/zen/v1/responses"},
	{"gpt-5.4-pro", "GPT 5.4 Pro", "https://opencode.ai/zen/v1/responses"},
	{"gpt-5.4-mini", "GPT 5.4 Mini", "https://opencode.ai/zen/v1/responses"},
	{"gpt-4", "GPT 4", "https://api.openai.com/v1/chat/completions"},
	{"gpt-3.5-turbo", "GPT 3.5 Turbo", "https://api.openai.com/v1/chat/completions"},
	{"claude-opus-4-7", "Claude Opus 4.7", "https://opencode.ai/zen/v1/messages"},
	{"claude-sonnet-4-6", "Claude Sonnet 4.6", "https://opencode.ai/zen/v1/messages"},
	{"claude-haiku-4-5", "Claude Haiku 4.5", "https://opencode.ai/zen/v1/messages"},
	{"gemini-3.1-pro", "Gemini 3.1 Pro", "https://opencode.ai/zen/v1/models/gemini-3.1-pro"},
	{"gemini-3-flash", "Gemini 3 Flash", "https://opencode.ai/zen/v1/models/gemini-3-flash"},
	{"qwen3.6-plus", "Qwen 3.6 Plus", "https://opencode.ai/zen/v1/chat/completions"},
	{"minimax-m2.5-free", "MiniMax M2.5 Free", "https://opencode.ai/zen/v1/chat/completions"},
	{"nemotron-3-super-free", "Nemotron 3 Super Free", "https://opencode.ai/zen/v1/chat/completions"},
}

// Message represents a chat message
type Message struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// Main TUI model
type model struct {
	messages      []Message
	currentInput  string
	loading       bool
	currentModel  AIModel
	showMenu      bool
	menuSelection int
}

// Initialize model
func initialModel() model {
	return model{
		messages:      []Message{},
		currentInput:  "",
		loading:       false,
		currentModel:  models[0],
		showMenu:      false,
		menuSelection: 0,
	}
}

// Initialize TUI
func (m model) Init() tea.Cmd {
	return nil
}

// Update handler
func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "esc":
			if m.showMenu {
				m.showMenu = false
			} else {
				return m, tea.Quit
			}
		case "m", "M":
			m.showMenu = !m.showMenu
		case "up", "k":
			if m.showMenu && m.menuSelection > 0 {
				m.menuSelection--
			}
		case "down", "j":
			if m.showMenu && m.menuSelection < len(models)-1 {
				m.menuSelection++
			}
		case "enter":
			if m.showMenu {
				m.currentModel = models[m.menuSelection]
				m.showMenu = false
			} else if m.currentInput != "" {
				m.loading = true
				prompt := m.currentInput
				m.currentInput = ""
				m.messages = append(m.messages, Message{Role: "user", Content: prompt})

				go func() {
					response := callAPI(m.currentModel, prompt)
					m.messages = append(m.messages, Message{Role: "assistant", Content: response})
					m.loading = false
				}()
			}
		case "backspace":
			if len(m.currentInput) > 0 {
				m.currentInput = m.currentInput[:len(m.currentInput)-1]
			}
		}

	case rune:
		if !m.showMenu {
			m.currentInput += string(msg)
		}
	}

	return m, nil
}

// Call API
func callAPI(model AIModel, prompt string) string {
	client := &http.Client{Timeout: 120 * time.Second}

	messages := []Message{{Role: "user", Content: prompt}}

	var req *http.Request
	var err error

	if strings.Contains(model.Endpoint, "/messages") {
		reqBody := map[string]interface{}{
			"model":      model.ID,
			"messages":   messages,
			"max_tokens": 4096,
		}
		body, _ := json.Marshal(reqBody)
		req, err = http.NewRequest("POST", model.Endpoint, strings.NewReader(string(body)))
	} else {
		reqBody := map[string]interface{}{
			"model":    model.ID,
			"messages": messages,
		}
		body, _ := json.Marshal(reqBody)
		req, err = http.NewRequest("POST", model.Endpoint, strings.NewReader(string(body)))
	}

	if err != nil {
		return "Error creating request"
	}

	req.Header.Set("Content-Type", "application/json")
	if apiKey := os.Getenv("OPENAI_API_KEY"); apiKey != "" {
		req.Header.Set("Authorization", "Bearer "+apiKey)
	}

	resp, err := client.Do(req)
	if err != nil {
		return fmt.Sprintf("Error: %v", err)
	}
	defer resp.Body.Close()

	var result map[string]interface{}
	json.NewDecoder(resp.Body).Decode(&result)

	if choices, ok := result["choices"].([]interface{}); ok && len(choices) > 0 {
		if msg, ok := choices[0].(map[string]interface{})["message"].(map[string]interface{}); ok {
			if content, ok := msg["content"].(string); ok {
				return content
			}
		}
	}

	if content, ok := result["content"].([]interface{}); ok && len(content) > 0 {
		if text, ok := content[0].(map[string]interface{})["text"].(string); ok {
			return text
		}
	}

	return "No response received"
}

// View renderer
func (m model) View() string {
	var b strings.Builder

	b.WriteString(tealStyle.Render("╭─ DekuAI ─────────────────────────────────────────╮\n"))
	b.WriteString(dimStyle.Render("│  press m → menu  •  esc/ctrl+c → quit           │\n"))
	b.WriteString(tealStyle.Render("╰─────────────────────────────────────────────────╯\n"))
	b.WriteString(brandStyle.Render("│ Model: ") + dimStyle.Render(m.currentModel.Name) + "\n\n")

	for _, msg := range m.messages {
		if msg.Role == "user" {
			b.WriteString(tealStyle.Render("You: ") + msg.Content + "\n\n")
		} else {
			b.WriteString(brandStyle.Render("DekuAI: ") + answerStyle.Render(msg.Content) + "\n\n")
		}
	}

	if m.loading {
		b.WriteString(dimStyle.Render("thinking..."))
	}

	if m.showMenu {
		b.WriteString("\n")
		b.WriteString(borderStyle.Render(" Select Model "))
		b.WriteString("\n\n")

		for i, model := range models {
			cursor := "  "
			if i == m.menuSelection {
				cursor = brandStyle.Render("> ")
			}
			name := model.Name
			if i == m.menuSelection {
				name = brandStyle.Render(name)
			}
			b.WriteString(fmt.Sprintf("%s%s\n", cursor, name))
		}

		b.WriteString("\n" + dimStyle.Render("↑↓ navigate • enter select • esc back"))
	}

	if !m.showMenu && !m.loading {
		b.WriteString("\n" + tealStyle.Render("Ask: ") + m.currentInput + "_")
	}

	return b.String()
}

func main() {
	p := tea.NewProgram(initialModel(), tea.WithAltScreen())
	if err := p.Start(); err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}
}