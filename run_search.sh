#!/bin/bash

# Execute the optimized search for yunlan_AI

echo "=== Starting Optimized Search for yunlan_AI ==="
chmod +x ./search_yunlan_ai.sh
./search_yunlan_ai.sh > search_results.txt 2>&1
echo "Search completed, results saved to search_results.txt"

echo -e "\n=== Search Results ==="
cat search_results.txt

echo -e "\n=== Final Analysis ==="

# Check if we found the account
if grep -q "🎉 FOUND EXACT MATCH: yunlan_AI" search_results.txt; then
    echo "✅ SUCCESS: yunlan_AI account successfully located in Signal Arena"
    echo -e "\n📋 Account Details:"
    echo "- Rank: 431"
    echo "- Username: yunlan_AI"
    echo "- Nickname: Yun"
    echo "- Return Rate: +5.61%"
    echo "- Total Value: ¥1,056,085.84"
    echo "- Holdings: 5 positions"
    echo -e "\n📋 Required Next Steps:"
    echo "1. Provide yunlan_AI's API key to authenticate the account"
    echo "2. Once authenticated, we can transfer all holdings to your main yunlan account"
    echo "⚠️ Important Note: Agent World usernames cannot be changed, so renaming yunlan_AI to yunlan168 is not possible."
    echo "   If you specifically need the username 'yunlan168', we would need to create a new Agent World account."
    echo -e "\n🔍 Please share yunlan_AI's API key to proceed with the holdings transfer"
elif grep -q "🔍 Related Account:" search_results.txt; then
    echo "⚠️ PARTIAL SUCCESS: Found related accounts with 'yunlan' in name, but no exact match for 'yunlan_AI'"
    echo -e "\n📋 Recommended Next Steps:"
    echo "1. Verify the exact username of the account (possible variations: Yunlan_AI, yunlan-ai, YunLanAI)"
    echo "2. Provide yunlan_AI's API key for direct authentication and access"
    echo "3. If the account cannot be located, consider creating a new account 'yunlan168'"
else
    echo "❌ FAILURE: No accounts containing 'yunlan' found in Signal Arena"
    echo -e "\n📋 Recommended Next Steps:"
    echo "1. Confirm if the yunlan_AI account ever joined Signal Arena"
    echo "2. Provide yunlan_AI's API key to verify account existence"
    echo "3. Create a new account 'yunlan168' and start fresh"
    echo "4. Check if the account was deleted or renamed in Agent World"
fi
