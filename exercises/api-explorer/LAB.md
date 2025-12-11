# Terraform Challenge: API Explorer

**Duration:** 30-45 minutes  
**Difficulty:** Intermediate  
**Providers:** http, random (no backend required!)

---

## Scenario

Your team wants to prototype a "quote of the day" dashboard. Before building the full app, they want you to prove that Terraform can pull data from external APIs and combine it with generated values.

You'll use Terraform to query public APIs, parse JSON responses, and combine data from multiple sources.

**No Docker. No cloud credentials. Just Terraform and the internet.**

---

## Your Mission

Build a Terraform configuration that queries public APIs and generates a personalized greeting.

### Requirements

| # | Requirement |
|---|-------------|
| 1 | Configure the `http` provider |
| 2 | Configure the `random` provider |
| 3 | Use `data "http"` to fetch a random quote from a public API |
| 4 | Use `random_pet` to generate a user's "codename" |
| 5 | Use `random_integer` to generate a "lucky number" (1-100) |
| 6 | Use **variables** for: quote API URL, pet name prefix, lucky number range |
| 7 | Create **outputs** for: the quote text, quote author, codename, lucky number, and a combined greeting |

### File Structure

```
.
├── main.tf          # Provider config and data sources
├── variables.tf     # Variable definitions
├── outputs.tf       # Output definitions
└── terraform.tfvars # (optional) Custom values
```

---

## Recommended APIs

Pick ONE of these free, no-auth APIs for your quote:

**Option A: Kanye REST** (Kanye West quotes) - SIMPLEST
```
https://api.kanye.rest
```
Returns: `{"quote": "quote text"}`

**Option B: Quotable API** (various quotes)
```
https://api.quotable.io/random
```
Returns: `{"content": "quote text", "author": "author name", ...}`

**Option C: Advice Slip API** (random advice)
```
https://api.adviceslip.com/advice
```
Returns: `{"slip": {"id": 123, "advice": "advice text"}}`

---

## Validation Checklist

Before calling it done, verify:

- [ ] `terraform init` completes successfully
- [ ] `terraform validate` shows no errors
- [ ] `terraform plan` shows resources to add (random resources create state!)
- [ ] `terraform apply` succeeds
- [ ] `terraform output` displays quote, codename, and lucky number
- [ ] Run `terraform apply` again - does the quote change? Does the codename stay the same?

---

## Resources

**Terraform HTTP Provider Documentation**  
https://registry.terraform.io/providers/hashicorp/http/latest/docs

**Terraform Random Provider Documentation**  
https://registry.terraform.io/providers/hashicorp/random/latest/docs

Key resources/data sources:
- `data "http"` - fetch from a URL
- `random_pet` - generate pet names
- `random_integer` - generate random numbers

---

## Rules of Engagement

1. **No AI assistance** - Read the docs!
2. **Struggle first** - Try for 10 minutes before asking for help
3. **Test the API first** - Use `curl` to see what the API returns before writing Terraform

---

## Hints (Open Only If Stuck)

<details>
<summary>Hint 1: Testing the API</summary>

Before writing any Terraform, test the API with curl:
```bash
curl https://api.kanye.rest
```

This shows you the exact JSON structure you'll need to parse.

</details>

<details>
<summary>Hint 2: Parsing JSON in Terraform</summary>

The `http` data source returns a `response_body` attribute (string). Use `jsondecode()` to parse it:

```hcl
locals {
  quote_data = jsondecode(data.http.quote.response_body)
}
```

Then access fields like `local.quote_data.quote` depending on the API structure.

</details>

<details>
<summary>Hint 3: Random Resources vs Data Sources</summary>

Note: `random_pet` and `random_integer` are **resources**, not data sources! They use `resource` blocks, not `data` blocks. This is because they create "managed randomness" that persists in state.

```hcl
resource "random_pet" "codename" {
  length = 2
}
```

</details>

<details>
<summary>Hint 4: Combining Outputs</summary>

Use string interpolation to create a combined greeting:

```hcl
output "greeting" {
  value = "Hello, ${random_pet.codename.id}! Your lucky number is ${random_integer.lucky.result}."
}
```

</details>

---

## Stretch Goals (If You Finish Early)

1. Add `random_shuffle` to pick from a list of greetings ("Hello", "Welcome", "Greetings")
2. Use `random_password` to generate a "secret token" (mark it sensitive!)
3. Add a second API call to get a joke or different type of quote
4. Use `locals` to format the quote nicely
5. Add `keepers` to control when random values regenerate

---

## Example Output

When working correctly, your output might look like:

```
codename = "bright-otter"
lucky_number = 42
quote_text = "I feel like I'm too busy writing history to read it."
greeting = "Hello, bright-otter! Your lucky number is 42."
```

---

## Key Concepts This Teaches

- **Data sources** - Reading external data into Terraform
- **JSON parsing** - Using `jsondecode()` to work with API responses  
- **Managed randomness** - How `random` resources persist in state
- **String interpolation** - Combining values in outputs
- **Provider configuration** - Setting up multiple providers

---

## Cleanup

```bash
terraform destroy  # Removes random resources from state
rm -rf .terraform .terraform.lock.hcl terraform.tfstate*
```

---

## Submission

Show your instructor:

1. `terraform output` results
2. Your code (they may ask you to explain JSON parsing)
3. Run `terraform apply` twice - explain why codename stays the same but quote may change

---

Query some APIs. Generate some randomness. No Docker required. 🎲
