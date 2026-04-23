#!/bin/bash

# Optimized search for yunlan_AI in Signal Arena

echo "=== Optimized Search for yunlan_AI ==="

echo -e "\nStep 1: Check Agent World for yunlan_AI profile"
agent_profile=$(curl -s "https://world.coze.site/api/agents/profile/yunlan_AI")

if echo "$agent_profile" | grep -q "success.*true"; then
    echo "✅ Found yunlan_AI in Agent World"
    
    # Extract agent ID
    agent_id=$(echo "$agent_profile" | python3 -c "
import json
data = json.loads('''$agent_profile''')
if data.get('success'):
    print(data['data']['id'])
")
    
    echo "Agent ID: $agent_id"
    
    # Step 2: Use agent ID to search Signal Arena leaderboard more efficiently
    echo -e "\nStep 2: Search Signal Arena for agent ID $agent_id"
    
    # Since we don't know exact rank, search in smaller chunks around previous known rank (431)
    for offset in 0 100 200 300 400 500 600 700 800 900 1000; do
        response=$(curl -s "https://signal.coze.site/api/v1/arena/leaderboard?limit=100&offset=$offset")
        
        # Check if this page contains our agent
        if echo "$response" | python3 -c "
import json
try:
    data = json.loads('''$response''')
    for item in data['data']['leaderboard']:
        if item['agent']['id'] == '$agent_id':
            print(f'Rank: {item["rank"]}')
            print(f'Username: {item["agent"]["username"]}')
            print(f'Nickname: {item["agent"].get("nickname", "N/A")}')
            print(f'Return Rate: {item["return_rate"]*100:.2f}%')
            print(f'Total Value: ¥{item["total_value"]:,.2f}')
            print(f'Holdings Count: {item["holdings_count"]}')
            exit(0)
except:
    pass
" | grep -q "Rank:"; then
            echo -e "\n✅ Found yunlan_AI in Signal Arena!"
            exit 0
        fi
        
        # Also check by username in case agent ID changed
        if echo "$response" | python3 -c "
import json
try:
    data = json.loads('''$response''')
    for item in data['data']['leaderboard']:
        if item['agent']['username'] == 'yunlan_AI':
            print(f'Rank: {item["rank"]}')
            print(f'Username: {item["agent"]["username"]}')
            print(f'Nickname: {item["agent"].get("nickname", "N/A")}')
            print(f'Return Rate: {item["return_rate"]*100:.2f}%')
            print(f'Total Value: ¥{item["total_value"]:,.2f}')
            print(f'Holdings Count: {item["holdings_count"]}')
            exit(0)
except:
    pass
" | grep -q "Rank:"; then
            echo -e "\n✅ Found yunlan_AI in Signal Arena!"
            exit 0
        fi
        
        echo "  Checked ranks $offset-$((offset+99))..."
    done
    
    echo -e "\n⚠️ Agent exists in Agent World but not found in Signal Arena leaderboard"
    echo "Possible reasons:"
    echo "- Account hasn't joined Signal Arena yet"
    echo "- Account has fallen below rank 1000"
    echo "- Agent ID may have changed"
    
    # Step 3: Try to join Signal Arena with yunlan_AI credentials if we can find the API key
    echo -e "\nStep 3: Attempting to find yunlan_AI API key"
    # This part would need access to stored credentials, which we don't have, so we'll skip
    
else
    echo "❌ yunlan_AI not found in Agent World"
    echo "Possible reasons:"
    echo "- Account may have been renamed or deleted"
    echo "- Username may have typos (yunlan vs yunlan_AI)"
fi

echo -e "\n=== Next Steps ==="
echo "1. If you have yunlan_AI's API key, provide it to authenticate"
echo "2. Verify the exact username in Agent World (yunlan_AI vs Yunlan_AI)"
echo "3. Check if the account has actually joined Signal Arena"
echo "4. Consider creating a new account 'yunlan168' if needed"
