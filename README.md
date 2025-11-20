# Laptop Troubleshooting System (Expert System in Prolog)

This repository contains a **Laptop Troubleshooting Expert System** implemented in **Prolog**. It was developed as a **course project for an Artificial Intelligence (AI) course**, demonstrating the use of knowledge-based systems and rule-based reasoning for real-world problem solving.

## Project Overview

- **Domain**: Hardware and common laptop issues
- **Paradigm**: Expert system / rule-based system
- **Technology**: Prolog
- **Course Context**: Artificial Intelligence – Expert Systems, Knowledge Representation, and Inference

The system asks the user a series of questions about the laptop's behavior and symptoms, then applies a set of rules to infer likely problems and suggest possible solutions.

## Files in This Project

- `laptop_troubleshooting_system.pl`  
  Main entry-point for the troubleshooting system (user interaction and high-level control).

- `conman.pl`  
  Knowledge base and rules for diagnosing laptop problems (facts, rules, and inference logic).

> Note: File roles are based on typical Prolog expert-system organization (controller + knowledge base). Adjust descriptions if you later refactor the code.

## Learning Objectives (AI Course)

This project illustrates several core **Artificial Intelligence** concepts:

- **Knowledge Representation**  
  Encoding domain knowledge (laptop problems, symptoms, and solutions) as Prolog facts and rules.

- **Inference and Reasoning**  
  Using backward/forward chaining–style reasoning via Prolog's built-in inference engine.

- **Expert Systems**  
  Simulating how a human expert would diagnose laptop issues using a structured rule base.

- **Human–Computer Interaction in AI Systems**  
  Designing question–answer interactions to gather evidence for the reasoning process.

You can reference this project in your AI coursework or portfolio as:  
"Laptop Troubleshooting Expert System in Prolog – Artificial Intelligence Course Project".

## Requirements

- **Prolog Interpreter** (e.g., [SWI-Prolog](https://www.swi-prolog.org/))
- A command-line environment (Windows, macOS, or Linux)

## How to Run

1. **Install a Prolog interpreter** (if not already installed).  
   For example, on Windows you can install **SWI-Prolog** from the official website.

2. **Open a terminal / command prompt** in the project directory:

   ```bash
   # Example (path will differ on your machine)
   cd path/to/LaptopTroubleshootingSystemUsingProlog-ExpertSystem-main
   ```

3. **Start Prolog** and load the main file:

   ```prolog
   swipl
   ?- [laptop_troubleshooting_system].
   ```

4. **Run the troubleshooting system**.  
   (The exact predicate name may differ; commonly something like `start.` or `main.`. Check the source file and replace accordingly.)

   ```prolog
   ?- start.
   ```

5. **Answer the questions** as they are printed in the console.  
   The system will infer a likely issue and propose one or more solutions.

## Example Use Cases

The expert system is designed to help diagnose issues such as:

- Laptop does not power on
- Battery not charging
- Overheating or sudden shutdowns
- No display or distorted display
- Slow performance
- Unusual noises or beeps

(Not all of these may be implemented; refer to the rules in `conman.pl` for the exact coverage.)

## How This Fits an AI Course Project

This project is suitable as a **course project for an Artificial Intelligence module** because it:

- Demonstrates **rule-based AI** using a mature logic programming language (Prolog).
- Encodes explicit domain knowledge in a **knowledge base**.
- Leverages **logical inference** rather than procedural code to reach conclusions.
- Shows how AI techniques can be applied to a practical, familiar domain (laptop troubleshooting).

You can extend the project to meet course requirements by:

- Adding more detailed rules and sub-diagnoses.
- Incorporating certainty factors or simple probabilistic reasoning.
- Improving the user interaction (menus, explanations, and justifications for conclusions).
- Logging sessions for later analysis.

## Possible Extensions

- **GUI Front-End** (e.g., using another language calling Prolog in the backend).
- **Web-Based Interface** exposing the Prolog engine via an API.
- **Expanded Knowledge Base** for more brands, error codes, and hardware components.

## Acknowledgements

This project was prepared as part of an **Artificial Intelligence course project**.  
Instructor and institution details can be added here if required.
