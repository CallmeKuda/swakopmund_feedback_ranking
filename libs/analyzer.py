import json
import matplotlib.pyplot as plt

def keyword_score(comment):
    positive_keywords = ["amazing", "beautiful", "fun", "great"]
    negative_keywords = ["boring", "expensive", "unsafe"]
    score = 0
    for word in positive_keywords:
        if word in comment.lower():
            score += 1
    for word in negative_keywords:
        if word in comment.lower():
            score -= 1
    return score

def calculate_score(entry):
    reviews = int(entry.get("reviews", "0").replace(",", ""))
    rating = float(entry.get("rating", "0"))
    return (reviews * 0.6) + (rating * 10)

def main(input="output/feedback_data.json"):
    with open(input, "r") as f:
        data = json.load(f)
    for item in data:
        item["score"] = calculate_score(item)
    ranked = sorted(data, key=lambda x: x["score"], reverse=True)
    with open("output/final_ranking.json", "w") as f:
        json.dump(ranked, f, indent=2)

    names = [x["name"] for x in ranked[:10]]
    scores = [x["score"] for x in ranked[:10]]

    plt.figure(figsize=(10, 6))
    plt.barh(names, scores, color="skyblue")
    plt.gca().invert_yaxis()
    plt.title("Top Tourist Attractions in Swakopmund")
    plt.xlabel("Score")
    plt.tight_layout()
    plt.savefig("graphs/ranking_chart.png")

if __name__ == "__main__":
    main()
