From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 4/5] hexagon: move core-y in arch/hexagon/Makefile to
 arch/hexagon/Kbuild
Date: Fri, 21 May 2021 12:29:52 +0200
Message-ID: <YKeLoDy3QddLd6jb@lillesand.fjasle.eu>
References: <20210512075729.60291-1-masahiroy@kernel.org>
 <20210512075729.60291-4-masahiroy@kernel.org>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1621596222; bh=GsepezfK7SCDw4QRe3az2jXkhTITx9Jxd1jiPnHi2vo=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=sozGZ0qcDkwXvXaDwvMTRYPoQLndJQZFs7rMelnUS7vu3+sZpz5ZjYy6IgzdToawt
         iNXsRGG7D39cB5QjcVKdWE6zBetAljk84BQg7JoAzswpN2mJWoy4LXrLnFEW/jpIwT
         g9CHTaSvF804qOMtn1hP8SA/rWSz9TRrjvc5y1Ao=
Content-Disposition: inline
In-Reply-To: <20210512075729.60291-4-masahiroy@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed 12 May 2021 16:57:28 GMT, Masahiro Yamada wrote:
> Use obj-y to clean up Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/hexagon/Kbuild   | 1 +
>  arch/hexagon/Makefile | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
> index a4e40e534e6a..d930c2f954d5 100644
> --- a/arch/hexagon/Kbuild
> +++ b/arch/hexagon/Kbuild
> @@ -1 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj += kernel/ mm/ lib/

This should probably be 'obj-y' instead of 'obj'?

Kind regards,
Nicolas
