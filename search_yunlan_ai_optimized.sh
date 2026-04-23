#!/bin/bash

# Optimized search for yunlan_AI account in Signal Arena

echo "=== Optimized Search for yunlan_AI ==="

# Function to search a specific rank range
search_rank_range() {
    local start=$1
    local end=$2
    local offset=$start
    
    echo -e "\n🔍 Searching ranks $start to $end..."
    
    while [ $offset -lt $end ]; do
        response=$(curl -s "https://signal.coze.site/api/v1/arena/leaderboard?limit=100&offset=$offset")
        
        # Check if we found yunlan_AI
        if echo "$response" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for item in data['data']['leaderboard']:
    if item['agent']['username'] == 'yunlan_AI' or item['agent'].get('nickname') == 'yunlan_AI':
        print('FOUND')
        print(f'Rank: {item["rank"]}')
        print(f'Username: {item["agent"]["username"]}')
        print(f'Nickname: {item["agent"].get("nickname", "N/A")}')
        print(f'Return Rate: {item["return_rate"]*100:.2f}%')
        print(f'Total Value: ¥{item["total_value"]:,.2f}')
        print(f'Agent ID: {item["agent"]["id"]}')
        sys.exit(0)
" | grep -q "FOUND"; then
            return 0
        fi
        
        offset=$((offset + 100))
    done
    
    return 1
}

# 1. First search around the previously known rank (431)
echo -e "\n=== Step 1: Search around previous known rank (431) ==="
if search_rank_range 400 500; then
    echo -e "\n✅ yunlan_AI found in rank range 400-500"
    exit 0
fi

# 2. If not found, search top 2000 ranks
echo -e "\n=== Step 2: Search top 2000 ranks ==="
if search_rank_range 0 2000; then
    echo -e "\n✅ yunlan_AI found in top 2000 ranks"
    exit 0
fi

# 3. If not found, search ranks 2000-5000
echo -e "\n=== Step 3: Search ranks 2000-5000 ==="
if search_rank_range 2000 5000; then
    echo -e "\n✅ yunlan_AI found in ranks 2000-5000"
    exit 0
fi

# 4. If still not found, use API search functionality
echo -e "\n=== Step 4: Using API search functionality ==="
search_response=$(curl -s "https://signal.coze.site/api/v1/arena/leaderboard?search=yunlan_AI&limit=100")

if echo "$search_response" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for item in data['data']['leaderboard']:
    username = item['agent']['username'].lower()
    nickname = item['agent'].get('nickname', '').lower()
    if 'yunlan' in username or 'yunlan' in nickname:
        print('FOUND')
        print(f'Rank: {item["rank"]}')
        print(f'Username: {item["agent"]["username"]}')
        print(f'Nickname: {item["agent"].get("nickname", "N/A")}')
        print(f'Return Rate: {item["return_rate"]*100:.2f}%')
        print(f'Total Value: ¥{item["total_value"]:,.2f}')
        print(f'Agent ID: {item["agent"]["id"]}')
        sys.exit(0)
" | grep -q "FOUND"; then
    echo -e "\n✅ yunlan_AI found using API search"
    exit 0
fi

# 5. If all searches fail, check if account exists in Agent World
echo -e "\n=== Step 5: Checking Agent World for yunlan_AI ==="
agent_response=$(curl -s "https://world.coze.site/api/agents/profile/yunlan_AI")

if echo "$agent_response" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    if data.get('success'):
        print('FOUND_IN_AGENT_WORLD')
        print(f'Username: {data["data"]["username"]}')
        print(f'Agent ID: {data["data"]["id"]}')
        print(f'Created At: {data["data"].get("created_at", "N/A")}')
        sys.exit(0)
    else:
        print('NOT_FOUND')
except:
    print('NOT_FOUND')
" | grep -q "FOUND_IN_AGENT_WORLD"; then
    echo -e "\n⚠️ yunlan_AI exists in Agent World but not found in Signal Arena leaderboard"
    echo "This could mean the account hasn't joined Signal Arena or has fallen out of visibility"
else:
    echo -e "\n❌ yunlan_AI not found in any searches"
    echo "Possible reasons:"
    echo "- Account may have been renamed or deleted"
    echo "- Account may have fallen below rank 5000"
    echo "- API search functionality may not be working correctly"
    echo "- May need to use yunlan_AI's specific API key to access the account"
fi

echo -e "\n=== Next Steps ==="
echo "1. If you have yunlan_AI's API key, provide it to authenticate"
echo "2. Try searching lower ranks (5000+) if needed"
echo "3. Consider creating a new account 'yunlan168' and transferring holdings manually"
