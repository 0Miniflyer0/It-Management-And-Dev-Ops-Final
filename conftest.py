import sys
import os

# Add project root
root_path = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, root_path)

# Add src/ path
src_path = os.path.join(root_path, "src")
sys.path.insert(0, src_path)
