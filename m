From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [patch 32/36] Hexagon: Comet platform support
Date: Wed, 17 Aug 2011 18:45:24 -0500
Message-ID: <CAHrUA37Z1A_UNaOrSu3VXyV3jJumEoCAU4hsqQm4RHraLrAu3A@mail.gmail.com>
References: <20110817163457.878854582@codeaurora.org> <20110817163522.852412019@codeaurora.org>
 <1490448.Ut7YRxkLUk@wuerfel>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+59jjRcwtYb6KFyM24JZnN69spEIavOYdNK1f5jFAWQ=;
        b=t8Vmf82eNNEHa1gKets2+3rPEe9/G13+HgFiCAVQm0olucLmiJsI556RfhStpRvZTm
         yYFnEEufpt3MG5nzfP1nxWvTwYeSFc/YsfBnXS01l8sveL7bz+F4qMo+dFR2wmSsRSkl
         JCC3dtQkWXT8J0uR63N4fzfE02nZQGGK6frgY=
In-Reply-To: <1490448.Ut7YRxkLUk@wuerfel>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On 17 August 2011 15:07, Arnd Bergmann <arnd@arndb.de> wrote:

>> + * linux/arch/hexagon/platform/comet/board.c
>
> We really don't want to have board files in new architectures any more. If your
> hardware is not fully discoverable, you should instead describe it in a device
> tree source file, see powerpc, microblaze, and the newer arm platforms.

Working on device-tree support, slowly but surely, but this could get
all tangled
for a while as many of the devices are common with the arm.  The goal is to
yank this file before the final submission. but for now, it seemed
easier to mail
this as a work in progress.

-- Linas
