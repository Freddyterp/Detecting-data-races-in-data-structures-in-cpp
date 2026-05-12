import matplotlib.pyplot as plt

data = [
    {"repo": "concurrentqueue", "rule": "G1", "fp": 60},
    {"repo": "concurrentqueue", "rule": "G3", "fp": 1},
    {"repo": "BlockingCollection", "rule": "G1", "fp": 0},
    {"repo": "BlockingCollection", "rule": "G3", "fp": 0},
    {"repo": "repoC", "rule": "G1", "fp": 15},
    {"repo": "repoC", "rule": "G3", "fp": 2},
]

# split data
g1_data = [d for d in data if d["rule"] == "G1"]
g3_data = [d for d in data if d["rule"] == "G3"]

def plot_rule(data, title):
    repos = [d["repo"] for d in data]
    values = [d["fp"] for d in data]

    plt.figure()
    plt.bar(repos, values)
    plt.title(title)
    plt.xlabel("Repository")
    plt.ylabel("False Positives")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()

plot_rule(g1_data, "G1 False Positives per Repository")
plot_rule(g3_data, "G3 False Positives per Repository")