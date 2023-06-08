![Pecunia Banner](/assets/readme/Banner.png)

# Pecunia: Personal Finance Management 💸

Pecunia is a cross-platform personal finance management app built with Flutter. It enables users to effectively track their expenses, set budgets, visualize financial trends, and much more. Designed with a local-first approach, Pecunia puts your financial data directly in your hands.

---

## Features (to be implemented lol) 💀

1. Transaction Tracking: Keep a record of all your income and expenses, each associated with a specific account.
2. Budget Management: Set one-time or recurring budgets, with features supporting diverse and complex budgeting needs.
3. Local-first Data: With a central database of transactions powered by drift (an SQLite wrapper).
4. Visual Analytics: Visualize your financial data through charts and diagrams to better understand your spending habits.

---

## Mockup and Design Showcase 📱

View the [Figma Project File](https://www.figma.com/file/eSFHv1qQIq0d7z23L45xiK/Project-Pecunia?type=design&node-id=909%3A3488&t=yNe4EOVObaxCtKNY-1), or play around with the [Figma Prototype](https://www.figma.com/proto/eSFHv1qQIq0d7z23L45xiK/Project-Pecunia?page-id=775%3A1156&type=design&node-id=787-617&viewport=876%2C191%2C0.97&scaling=scale-down&starting-point-node-id=787%3A617) (I made sure the animations look cute).

![Mockup 1](/assets/readme/Mockup%20Group%201.png)
![Mockup 2](/assets/readme/Mockup%20Group%202.png)

---

## Development Roadmap 🚀

### 🏗️ Phase 1: Basic Features

- [ ] Transaction tracking.
- [ ] Simple budget creation and management.
- [ ] Local database setup with `drift`.
- [ ] Simple authentication and integration with `supabase`.

### 🧑🏼‍💻 Phase 2: Advanced Features

- [ ] Implementing recurring budgets.
- [ ] Visual analytics and reports.
- [ ] Sub-Budgets (Multi-category budgeting).

### 😋 Phase 3: User Experience Enhancements

- [ ] Fully customizable dashboard.
- [ ] Profile page with a cool looking pseudo-3d membership card.
- [ ] Budget exception handling (transactions that don't fit budget criterion, but still wants to be included in a budget.)
- [ ] Alerts, reminders, notifications, etc.

### 💨 Phase 4: Performance Optimization

- [ ] Whatever tuning I can do from here.
- [ ] Data aggregation for more efficient data retrieval.

### 🔥 Future Capabilities

- [ ] Remote Sync.
- [ ] GPT4 (woo woo)?
- [ ] More interactive and advanced data visualization.
- [ ] Desktop apps? Mac and Windows or even Web?

---

# Temporary Wiki 🔎?

## General Architecture

The architecture of the app follows (or attempts to with its best) the Clean Architecture Paradigm. With a feature-first or feature-enclosed approach. In layman terms, I group everything into chunks of "features". Each feature will have the folder structure as such:

1. `data` will communicate with the dirty outer world.
2. `domain` will communicate with `data` and provide a clean API.
3. `interactor` (more widely known as `usecase`) will be the Providers which will coordinate data from the `domain` layer, as well as combine with other features' providers if necessary.
4. `presentation` will communicate with its feature `interactor` to build UI.

> **Why use `interactor` and not `usecase`?** \
> I really want the folder structure to be ordered as it should, with `data` being the bottom (or top in the folder structure) and `presentation` being the top (vice versa).
