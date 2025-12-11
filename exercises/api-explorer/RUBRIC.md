# Grading Rubric: API Explorer Challenge

**Total Points: 20**

---

## Core Requirements (14 points)

| Requirement | Points | Criteria |
|-------------|--------|----------|
| Providers configured | 2 | Both `http` and `random` providers declared |
| HTTP data source | 3 | `data "http"` fetches from API, response parsed with `jsondecode()` |
| random_pet resource | 2 | Generates codename with configurable length/prefix |
| random_integer resource | 2 | Generates lucky number within specified range |
| Variables used | 2 | At least 3 variables (URL, prefix, range min/max) |
| Outputs defined | 3 | Quote, codename, lucky number, and combined greeting |

---

## Code Quality (4 points)

| Criteria | Points |
|----------|--------|
| File organization | 1 | Separate files for main/variables/outputs |
| Use of locals | 1 | JSON parsing done in locals block |
| Variable descriptions | 1 | All variables have descriptions |
| Working solution | 1 | `terraform apply` succeeds |

---

## Stretch Goals (Bonus - up to 4 points)

| Goal | Points |
|------|--------|
| random_shuffle for greetings | 1 |
| random_password (sensitive) | 1 |
| Second API call | 1 |
| keepers for controlled regeneration | 1 |

---

## Scoring Guide

| Score | Grade | Notes |
|-------|-------|-------|
| 18-20+ | A | Excellent - completed with quality and possibly stretch goals |
| 15-17 | B | Good - all requirements met, minor issues |
| 12-14 | C | Satisfactory - mostly working, some gaps |
| 9-11 | D | Needs improvement - significant issues |
| 0-8 | F | Incomplete - did not meet minimum requirements |

---

## Quick Check Commands

```bash
# Verify configuration
terraform validate

# Apply and check outputs
terraform apply -auto-approve
terraform output

# Verify state contains random resources
terraform state list
# Should show:
# random_integer.lucky
# random_pet.codename
# data.http.quote

# Re-apply to show randomness behavior
terraform apply -auto-approve
# Codename should stay same, quote may change
```

---

## Common Issues

1. **Using `body` instead of `response_body`** - The http provider attribute changed names
2. **Forgetting `jsondecode()`** - The response is a string, not an object
3. **Using `data` instead of `resource` for random** - random_pet/integer are resources!
4. **Wrong JSON path** - Different APIs have different structures (test with curl first)
5. **API rate limiting** - Some APIs limit requests; if errors occur, wait and retry
