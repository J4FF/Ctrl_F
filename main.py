import discord
import wikipedia as wiki
from discord.ext import commands
import translators.server as tss


bot = commands.Bot(command_prefix="!", intents=discord.Intents.all(), help_command=None)


# translator
async def translate_text(text, target):
    result = tss.google(text, "en", target)
    return result


flags = ['🇧🇷', '🇩🇪', '🇫🇷', '🇮🇹', '🇯🇵', '🇳🇱', '🇷🇺', '💀', '🇵🇱']

# LANGUAGES_INVERTER
LANGUAGES_INVERTED = {
    '🇧🇷': 'pt',  # Portugiesisch (Brasilien)
    '🇩🇪': 'de',  # Deutsch
    '🇫🇷': 'fr',  # Französisch
    '🇮🇹': 'it',  # Italienisch
    '🇯🇵': 'ja',  # Japanisch
    '🇳🇱': 'nl',  # Niederländisch
    '🇷🇺': 'ru',  # Russisch
    '💀': 'la',  # Latein
    '🇵🇱': 'pl',  # Polsky
}


@bot.event
async def on_message(message):
    if message.author.bot:
        return
    # the question is separated from the "!f"
    if message.content.startswith("!f"):
        frage = message.content[len("!f"):].strip()
        answer = frage
    try:
        info = wiki.summary(answer)
        msg = await message.channel.send(f'```{info}```')
        for flag in flags:
            await msg.add_reaction(flag)

    # Error Handler
    except discord.errors.HTTPException:
        await message.channel.send("Too many results, please try to describe your request in more detail.")
        return

    except wiki.exceptions.PageError:
        await message.channel.send("No search results could be found.")
        return

    except wiki.exceptions.DisambiguationError:
        await message.channel.send("No unique search results could be found, please write in more detail")
        return


@bot.event
async def on_reaction_add(reaction, user):
    if user == bot.user:
        return
    # Get the Emoji
    emoji = reaction.emoji

    # List Checker
    inflags = False
    for i in flags:
        if i == emoji:
            inflags = True
    if not inflags:
        await reaction.remove(user)
        return

    # Get the message from Reaction
    message = reaction.message

    # Translate
    translated_text = await translate_text(message.content, LANGUAGES_INVERTED[emoji])

    # Send translated message
    await message.channel.send(f'``{translated_text}``')


@bot.event
async def on_ready():
    print("Bot is Up!")
    try:
        synced = await bot.tree.sync()
        print(f"Synced {len(synced)} command(s)")
    except Exception as e:
        print(e)


@bot.tree.command(name='search', description="Sends the bot's latency.")
async def search(
        interaction: discord.Interaction,
        keyword: str) -> None:
    try:
        command_text = keyword
        frage = command_text
        summary = wiki.summary(frage)

    except discord.errors.HTTPException:
        await interaction.response.send_message("Too many results, please try to describe your request in more detail.")
        return

    except wiki.exceptions.PageError:
        await interaction.response.send_message("No search results could be found.")
        return

    except wiki.exceptions.DisambiguationError:
        await interaction.response.send_message("No unique search results could be found, please write in more detail")
        return
    await interaction.response.send_message(summary, ephemeral=True)


bot.run("YOUR_BOT_TOKEN")
