@echo off
title AnarchyAI Setup Script
color 0a
echo Running setup...

:: Step 1: Open command prompt in administrator mode
powershell Start-Process cmd.exe -Verb RunAs -ArgumentList "/k CD %CD% & color 0a"

:: Step 2: Check winget version
winget --version
if %errorlevel% neq 0 (
    echo Please update your Windows and then re-run the setup.
    goto :eof
)

:: Step 3: Check Python version and install if not found
python --version
if %errorlevel% neq 0 (
    echo Python not found. Installing Python 3.11...
    winget install Python.Python.3.11
    if %errorlevel% neq 0 (
        echo Error installing Python. Setup aborted.
        goto :eof
    )
)

:: Step 4: Create a virtual environment
python -m venv anarchyai
if %errorlevel% neq 0 (
    echo Error creating virtual environment. Setup aborted.
    goto :eof
)

:: Step 5: Activate the virtual environment
anarchyai\Scripts\activate
if %errorlevel% neq 0 (
    echo Error activating virtual environment. Setup aborted.
    goto :eof
)

:: Step 6: Install dependencies in development mode
python -m pip install -e ."[dev]"
if %errorlevel% neq 0 (
    echo Error installing dependencies. Setup aborted.
    goto :eof
)

echo Setup completed successfully.
