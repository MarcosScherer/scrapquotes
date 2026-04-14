from playwright.sync_api import sync_playwright
import json

def scrape_quotes():
    data = []

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto("https://quotes.toscrape.com/", wait_until="domcontentloaded")

        quotes = page.locator(".quote")
        total = quotes.count()

        for i in range(total):
            quote = quotes.nth(i)
            text = quote.locator(".text").inner_text().strip()
            author = quote.locator(".author").inner_text().strip()
            tags = quote.locator(".tags .tag").all_inner_texts()

            data.append({
                "text": text,
                "author": author,
                "tags": tags
            })

        browser.close()

    with open("quotes.json", "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f"OK - {len(data)} citações salvas em quotes.json")

if __name__ == "__main__":
    scrape_quotes()