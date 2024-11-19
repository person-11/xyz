import random

class Node:
    def __init__(self, id, is_faulty=False):
        self.id = id
        self.is_faulty = is_faulty

    def send_value(self, value):
        # Faulty nodes may send random or incorrect values
        if self.is_faulty:
            return random.choice(["faulty_value", value, None])
        return value

class ByzantineFaultTolerance:
    def __init__(self, num_nodes, num_faulty):
        self.num_nodes = num_nodes
        self.num_faulty = num_faulty
        self.nodes = self.initialize_nodes()

    def initialize_nodes(self):
        nodes = []
        for i in range(self.num_nodes):
            is_faulty = i < self.num_faulty
            nodes.append(Node(id=i, is_faulty=is_faulty))
        return nodes

    def reach_consensus(self, proposed_value):
        # Step 1: Each node broadcasts its value
        broadcasts = {node.id: node.send_value(proposed_value) for node in self.nodes}

        # Step 2: Nodes collect votes
        votes = {}
        for node_id, value in broadcasts.items():
            if value is not None:
                votes[value] = votes.get(value, 0) + 1

        # Step 3: Decide on the majority value
        majority_value = max(votes, key=votes.get, default=None)

        # Check if consensus is possible
        if votes.get(majority_value, 0) > self.num_nodes // 3 * 2:
            return majority_value
        return None

def simulate_bft():
    num_nodes = 10  # Total number of nodes
    num_faulty = 3  # Number of faulty nodes (<= num_nodes // 3)

    bft = ByzantineFaultTolerance(num_nodes=num_nodes, num_faulty=num_faulty)

    proposed_value = "valid_value"
    consensus = bft.reach_consensus(proposed_value)

    print("Proposed Value:", proposed_value)
    print("Faulty Nodes:", num_faulty)
    print("Consensus Reached:" if consensus else "Consensus Not Reached")
    if consensus:
        print("Consensus Value:", consensus)

if __name__ == "__main__":
    simulate_bft()
