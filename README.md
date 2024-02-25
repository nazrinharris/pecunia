![Pecunia Banner](/assets/readme/banner_v2.png)

# Pecunia: Personal Finance Management 💸

Pecunia is a cross-platform personal finance management app built with Flutter. It enables users to effectively track their expenses, set budgets, visualize financial trends, and much more.

---

```
TODO: Talk about current features
TODO: Talk about Discussions, Wiki, and Projects
TODO: Update README to look less like a marketing page
```

## Features

1. Transaction Tracking: Keep a record of all your income and expenses, each associated with a specific account.
2. Budget Management: Set one-time or recurring budgets, with features supporting diverse and complex budgeting needs.
3. Local-first Data: With a central database of transactions powered by drift (an SQLite wrapper).
4. Visual Analytics: Visualize your financial data through charts and diagrams to better understand your spending habits.

---

## Mockup and Design Showcase 📱

View the [Figma Project File](https://www.figma.com/file/eSFHv1qQIq0d7z23L45xiK/Project-Pecunia?type=design&node-id=909%3A3488&t=yNe4EOVObaxCtKNY-1), or play around with the [Figma Prototype](https://www.figma.com/proto/eSFHv1qQIq0d7z23L45xiK/Project-Pecunia?page-id=775%3A1156&type=design&node-id=787-617&viewport=876%2C191%2C0.97&scaling=scale-down&starting-point-node-id=787%3A617) (I made sure the animations look cute).

![Mockup 1](/assets/readme/mockup_grp_1.png)
![Mockup 2](/assets/readme/mockup_grp_2.png)

---

## Development Roadmap 🚀

### 🏗️ Phase 1: Basic Features

(`0.1.0`)

- [x] Simple authentication and integration with `supabase`.
- [x] Local database setup with `drift`.
- [x] Accounts creation, deletion, editing, and viewing.
- [x] Transaction creation, deletion, editing and viewing.
- [x] Transferring funds between accounts.
- [x] Multi-currency transactions.
- [x] Transaction categories.
- [ ] Basic UI capabilities (as in, similar looks and functionality to mockup) 
- [ ] Local Authentication and Multi-User-Account capability

### 🧑🏼‍💻 Phase 2: Advanced Features

(`0.2.0`)

- [ ] Improved logging and crashlytics (Using `sentry` possibly?)
- [ ] Goals (Piggybank-like)
- [ ] Debt/Loan Tracking
- [ ] Nested categories
- [ ] Simple timed budget creation, deletion, editing, and viewing.
- [ ] More diverse visual analytics
- [ ] Implementing recurring budgets.
- [ ] Sub-Budgets (Multi-category budgeting).

(`0.2.1`)
- [ ] UI Upgrade! (Turn it into what it should've looked like)

(`0.2.2`) (possible)
- [ ] Implement custom backend, `pecunia-backend`

### 😋 Phase 3: Quality of Life Improvements

- [ ] Fully customizable dashboard.
- [ ] Profile page with a cool looking pseudo-3d membership card.
- [ ] Budget exception handling (transactions that don't fit budget criterion, but still wants to be included in a budget.)
- [ ] Alerts, reminders, notifications, etc.

### 🔥 Future Capabilities

- [ ] Remote Sync.
- [ ] GPT4 (ooo the ai buzzword)
- [ ] More interactive and advanced data visualization.
- [ ] Desktop apps? Mac and Windows or even Web?

---
## Setup Recommendation
Here's a couple of recommendations (my setup):

1. Use `VSCode`
2. Enabling the `File Nesting` setting (`"explorer.fileNesting.enabled": true`)
3. Disabling auto-expand nested files (`"explorer.fileNesting.expand": false`)
4. Setting the capture for `File Nesting` to `.freezed` and `.g` files.

> Unfortunately, it doesn't seem like I can disable auto-expand if a folder only has one file (provided that the other files in the folder is nested under one file)