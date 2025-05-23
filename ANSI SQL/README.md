# ANSI SQL Exercises - MySQL

This repository contains solutions to 25 ANSI SQL exercises using MySQL, based on the provided schema and sample data.

## File

- ansi_sql_exercises.sql: Contains all 25 SQL queries, each preceded by a comment marking the exercise number and description.

## How to Use

1. Open your MySQL environment or workbench.
2. Copy the entire contents of ansi_sql_exercises.sql.
3. Run queries individually by selecting the query you want to execute or run the entire script if desired.
4. Each query is independent and can be run separately.

## Repository Structure

ansi-sql-exercises/
│
├── ansi_sql_exercises.sql
└── README.md


## Notes

- Queries are designed for MySQL 8.0+.
- The schema and sample data must be loaded before running these queries.
- Each query is commented with the exercise number and title for easy navigation.

## How to Upload Using VS Code and GitHub

1. Open VS Code and create a new folder named ansi-sql-exercises.
2. Inside the folder, create two files:
   - ansi_sql_exercises.sql (paste the queries here)
   - README.md (paste this README content here)
3. Initialize a git repository:
   ```bash
   git init
   git add .
   git commit -m "Added all 25 ANSI SQL exercises in a single file"

4.Create a new repository on GitHub (name it as you like).

5.Connect local repo to GitHub:

git remote add origin https://github.com/yourusername/ansi-sql-exercises.git
git branch -M main
git push -u origin main