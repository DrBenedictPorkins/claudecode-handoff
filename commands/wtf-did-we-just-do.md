Prompt: Developer Session Summary for Knowledge Base

Please summarize this session for archival in my personal developer knowledge base (Obsidian). Your output should:

- Start with a short, descriptive title
- Include concise, high-signal summaries of:
  - Technical discoveries, solutions, and "aha" moments
  - Bugs or blockers and how they were resolved (with reasoning)
  - Key decisions and trade-offs, especially if we considered multiple approaches
  - Tools, commands, config, or code patterns worth saving
- Include narrative-style explanation where it improves clarity or captures deeper insight (e.g., explaining why something worked or what we learned)
- Use bullets grouped by theme, with short subheadings if useful
- Include code snippets or example commands when relevant

Tone: Technical and clear. Assume I'm reviewing this weeks later to understand both *what we did* and *why we did it*.

---

Examples:

---

Title: Race Condition in Node.js Job Processor – Diagnosis and Fix

- **Bug Summary**:  
  Job processing queue was sometimes skipping entries or throwing intermittent DB lock errors. After logging internals, we traced it to `Promise.all()` used during batch inserts to SQLite.

- **Resolution & Discovery**:  
  Replacing `Promise.all()` with an `async for...of` loop fixed the problem. SQLite (even in WAL mode) can't safely handle concurrent writes in tight loops without locking. This revealed that parallelism at the Node level doesn't always benefit I/O-bound operations if the backend can't handle concurrency.

- **Key Insight**:  
  Parallelization ≠ speedup, especially with SQLite. Serial writes ensured reliability and only added 20–30ms per batch.

- **Code Fix Snippet**:
  ```js
  for (const item of batch) {
    await db.insert(item);
  }
  ```

---

Title: Refactoring Spring Boot Config for Testability

- **Problem**:  
  We struggled to mock service configuration in tests because values were injected using `@Value`, which doesn't support property overriding cleanly in test slices.

- **Solution**:  
  Migrated to using `@ConfigurationProperties` + constructor injection, which made it easier to pass mock config in tests and reduced reflection complexity.

- **Tooling Note**:  
  Used `@TestConfiguration` with a nested class to override the bean in test scope. Confirmed the Spring context booted correctly without leaking production config.

---

Title: Node.js CLI Tool – Dependency Hell and ESM Fix

- **Build Issue**:  
  Encountered "Cannot use import statement outside a module" when bundling a CLI tool with `esbuild`.

- **Resolution Path**:
  - Added `"type": "module"` in `package.json`
  - Explicitly changed `.js` imports to `.mjs` or added file extensions in imports
  - Used `esbuild --platform=node --target=node20` to correctly bundle ESM

- **Takeaway**:  
  ESM tooling remains tricky. Even with `esbuild`, Node's native ESM rules require precise file extensions and careful control over interop with CommonJS modules.