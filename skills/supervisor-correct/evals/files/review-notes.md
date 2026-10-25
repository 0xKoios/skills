# Review notes: shop-api, last six weeks

Comments collected from pull request reviews on the shop-api repo.

## PR 412: weekly sales report

- reports/weekly.py line 31: `SELECT * FROM orders` pulls every column, including the card token. Name the columns you need.
- reports/weekly.py line 58: the start date is hard-coded as "2025-01-01". It will be wrong next quarter. Take it from the report window.

## PR 419: customer export

- exports/customers.py line 12: `SELECT * FROM customers` again. The export now leaks the new internal_notes column. Same comment as on 412.
- exports/customers.py line 40: the code compares against 2025-03-14 and passes only because the fixture uses that date. Don't hard-code the date.

## PR 427: refund dashboard

- dashboard/refunds.py line 22: `SELECT * FROM refunds` is back. Three PRs in a row now. Please list the columns.

## Other

- Nothing else repeated more than once in this period.
