From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap/hexagon: Properly fix the generic IO helpers
Date: Mon, 22 Aug 2022 17:05:28 +0100
Message-ID: <166118432866.209062.6307998506272128787.b4-ty@kernel.org>
References: <20220818121227.151016-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184330;
        bh=d3sUkYp6dks0UkiVe4t0K0fOPEi7K0LdjCO3EOU4CHU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PKaA0zHIXDboIrSbFj2n2Snj2sRRFvvZl5ts3UbD0yRBW5JmZVehRhl3HXUwnpK9o
         RAQSGvE4kXpO1JFJnJFcxlILkSPJK4S9vowAaKKiMGFq37BKFgmZWBeeXkXVEIq9Ij
         Rjn6ISoCm/Dwm83lcVU5SQFDukbSwcNySHpcRUmmFn2uv13XQz9umWVleoqmvNTbfm
         rVjMv2A8Mzg7EhXCN1bqtOqkqIImzxJePK7OmSBy6X67fegVnKLI1gxEINP4/aEHMa
         0qvEjLjC6+en6GWDytUQKHxghNuNkx4njeueghQ1sPcthh15xZ2o6hQlV+Nvem69IY
         KHgWGHm5DYxdg==
In-Reply-To: <20220818121227.151016-1-linus.walleij@linaro.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>

On Thu, 18 Aug 2022 14:12:27 +0200, Linus Walleij wrote:
> I was too naive in just including <asm-generic/io.h> into
> hexagon: one has to specify defines for every call that uses
> a (static) inline or this will not work.
> 
> Fix it up by providing proper defines for all shorthands that
> hexagon provides.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap/hexagon: Properly fix the generic IO helpers
      commit: f8f60615379c1b36d9220f3886fb9b229e95d8cd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
