import json
import matplotlib.pyplot as plt
import os

# Load reviews
with open('output/nts_reviews.json', 'r') as f:
    reviews = json.load(f)

# Count how many comments each unique name made
counter = {}
for r in reviews:
    name = r.get('name', 'Anonymous')
    counter[name] = counter.get(name, 0) + 1

# Plotting
names = list(counter.keys())
counts = list(counter.values())

plt.figure(figsize=(10, 6))
plt.bar(names, counts)
plt.xticks(rotation=45, ha='right')
plt.title('Number of Comments per Reviewer')
plt.tight_layout()

os.makedirs('output', exist_ok=True)
plt.savefig('output/review_graph.png')
