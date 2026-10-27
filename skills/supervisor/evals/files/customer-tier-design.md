# Customer tier on gold orders

Gate: questions done 2026-10-24

## Intent and the why

Finance wants to split order revenue by customer tier without joining the customers table in every report.

## Goals

- Add a customer_tier column to orders_gold, derived from trailing 12-month spend.
- Tiers are bronze, silver and gold, with thresholds 0, 1000 and 5000.

## Non-goals

- Changing how spend is calculated.

## Anti-goals

- A tier that changes for past orders when a customer's spend changes later.

## Constraints

- orders_gold is rebuilt nightly by the orders_gold job.

## Decided by the user

- The tier is fixed at order time.

## Builder's calls

- The column is nullable for orders before 2023.

## Left to the builder

- Where the tier lookup lives.
