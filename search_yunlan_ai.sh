#!/bin/bash

# Optimized search for yunlan_AI using Signal Arena API search functionality

echo "=== Optimized Search for yunlan_AI ==="
echo "Using targeted search parameter instead of paginating through all ranks"
echo -e "\n"

# API Authentication details
API_KEY="agent-world-79a26d1d02f65239ec9fc4a886f541082914ef73637798d3"
BASE_URL="https://signal.coze.site/api/v1/arena"

echo "📡 Authenticating with Agent World API key..."
echo "🔍 Searching for accounts containing 'yun' in username/nickname..."
echo -e "\n"

# Execute search using Signal Arena API's search parameter
SEARCH_RESPONSE=$(curl -s "${BASE_URL}/leaderboard?search=yun&limit=50" -H "agent-auth-api-key: ${API_KEY}")

# Check if request was successful
if echo "${SEARCH_RESPONSE}" | grep -q "success.*true"; then
    echo "✅ API request successful"
    echo -e "\n📊 Search Results:"
    echo "-" * 70
    
    # Parse and display results using Python
    echo "${SEARCH_RESPONSE}" | python3 -c "
import json
data = json.loads('''${SEARCH_RESPONSE}''')
found = False

for item in data['data']['leaderboard']:
    username = item['agent']['username']
    nickname = item['agent'].get('nickname', 'N/A')
    
    if 'yunlan_AI' in username or 'yunlan_AI' in nickname:
        found = True
        print('🎉 FOUND EXACT MATCH: yunlan_AI')
        print(f'Rank: {item["rank"]:>6,}')
        print(f'Username: {item["agent"]["username"]:>20}')
        print(f'Nickname: {nickname:>20}')
        print(f'Return Rate: {item["return_rate"]*100:>14.2f}%')
        print(f'Total Value: ¥{item["total_value"]:>15,.2f}')
        print(f'Agent ID: {item["agent"]["id"]}')
        print('-' * 70)
    
    elif 'yunlan' in username or 'yunlan' in nickname:
        print(f'🔍 Related Account: {username}')
        print(f'Rank: {item["rank"]:>6,}')
        print(f'Nickname: {nickname:>20}')
        print(f'Return Rate: {item["return_rate"]*100:>14.2f}%')
        print('-' * 70)

if not found:
    print('❌ No exact match found for yunlan_AI')
    print('💡 Try searching with different variations: Yunlan_AI, yunlan-ai, YunLanAI')
"
    
    echo -e "\n📋 Next Steps:"
    echo "1. To transfer holdings or rename, we need yunlan_AI's API key"
    echo "2. If rename is not possible (Agent World usernames can't be changed), we'll need to transfer to yunlan account"
    echo "3. If we can't locate yunlan_AI, consider creating a new account 'yunlan168'"
    echo -e "\n🔑 Please provide yunlan_AI's API key to proceed"
    
else:
    echo "❌ API request failed"
    echo "Response: ${SEARCH_RESPONSE}"
    echo -e "\n💡 Possible reasons:"
    echo "- API key may have expired"
    echo "- Signal Arena API may be down"
    echo "- Authentication header format is incorrect"
fi
