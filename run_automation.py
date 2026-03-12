import os
import subprocess
import sys

def run_script(script_name):
    print(f"--- Running {script_name} ---")
    try:
        # Use sys.executable to ensure we use the same python interpreter
        result = subprocess.run([sys.executable, f"scripts/{script_name}"], check=True)
        print(f"--- {script_name} finished ---\n")
    except subprocess.CalledProcessError as e:
        print(f"Error running {script_name}: {e}\n")

def main():
    # 1. Update dates and lifecycle
    run_script("blog_lifecycle_manager.py")
    
    # 2. Auto tagging
    run_script("auto_tagger.py")
    
    # 3. Extract subjects (for anime)
    run_script("extract_subject.py")
    
    # 4. Update daily recommendations
    # Note: This requires DEEPSEEK_API_KEY and EXA_API_KEY env vars
    run_script("update_daily.py")

if __name__ == "__main__":
    main()
