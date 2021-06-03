From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and
 select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Date: Wed, 2 Jun 2021 18:17:09 -0700
Message-ID: <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
References: <20210521011239.1332345-1-nathan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622683030;
        bh=ZZSgtz1O7vXnB7wNRF8Y8LlDQZi1WwpqQfJvHz5bu6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qoch9BCdyC8kVv3yCNZkT1g36Sdj2yVjowUBaB07sk59NmRiIwdrkIh/25EE5mAOP
         iqi95KyHpggyg/BpN+p2NOklidv5unS9kehBQadAMqd/omAjHhF5lMHdt3rBvMRFIz
         HXPuCWLQBiFrICQnvoHkI6RZvBkpGgfgAP0VSxXBLpgUQys0BTVYW8YXeQiLNlC9E3
         I2tM4BZjKWGaeRkK3LE/IsafAlNYLdk0zSQsXBMEQ5aXV5xz5HBXmest/guXTL9tTj
         gHyKGk0W3uSfY9hi+dbREBUEI7w7b5oQHaDyXBmcT977PcxtpuqfuLP1vYOJpe0HJu
         SqMVFUR98+7Mw==
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On 5/20/2021 6:12 PM, Nathan Chancellor wrote:
> Hi all,
> 
> This series fixes an error with ARCH=hexagon that was pointed out by
> the patch "mm/slub: use stackdepot to save stack trace in objects",
> which is in -mm/-next.
> 
> The first patch fixes that error by handling the '.irqentry.text' and
> '.softirqentry.text' sections.
> 
> The second patch switches Hexagon over to the common DISCARDS macro,
> which should have been done when Hexagon was merged into the tree to
> match commit 023bf6f1b8bf ("linker script: unify usage of discard
> definition").
> 
> The third patch selects CONFIG_ARCH_WANT_LD_ORPHAN_WARN so that
> something like this does not happen again.
> 
> Nathan Chancellor (3):
>    hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
>    hexagon: Use common DISCARDS macro
>    hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
> 
>   arch/hexagon/Kconfig              | 1 +
>   arch/hexagon/kernel/vmlinux.lds.S | 9 +++------
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 7a42b92b6d30c3f09629c7d5ada9e3de2aba01af
> 

Brian, did you have any comments on this series? ARCH=hexagon defconfig 
is currently broken in -next, it would be a real shame if this continued 
to regress after you just got Hexagon building in mainline. These 
patches seem like they would be worthy of a 5.13 pull request. 
Otherwise, Andrew could pick them up with your ack and stick them in 
front of "mm/slub: use stackdepot to save stack trace in objects" so 
that there is no build regression.

Cheers,
Nathan
