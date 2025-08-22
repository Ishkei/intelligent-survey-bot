#!/bin/bash

# 🚀 Intelligent Survey Bot - Deployment Script
# This script helps deploy the project to GitHub Pages

echo "🤖 Intelligent Survey Bot - Deployment Script"
echo "=============================================="

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Please run this script from the project root."
    exit 1
fi

# Check git status
echo "📊 Checking git status..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: You have uncommitted changes."
    echo "   Consider committing them before deployment."
    read -p "   Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Deployment cancelled."
        exit 1
    fi
fi

# Check if remote origin exists
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "❌ Error: No remote origin found."
    echo "   Please add your GitHub repository as origin first:"
    echo "   git remote add origin https://github.com/yourusername/intelligent-survey-bot.git"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push -u origin $CURRENT_BRANCH

if [ $? -eq 0 ]; then
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "🌐 To enable GitHub Pages:"
    echo "   1. Go to your repository on GitHub"
    echo "   2. Click Settings → Pages"
    echo "   3. Select source: 'Deploy from a branch'"
    echo "   4. Choose branch: '$CURRENT_BRANCH'"
    echo "   5. Click Save"
    echo ""
    echo "   Your bot will be available at:"
    echo "   https://yourusername.github.io/intelligent-survey-bot/"
    echo ""
    echo "🎉 Deployment complete!"
else
    echo "❌ Failed to push to GitHub. Please check your credentials and try again."
    exit 1
fi
