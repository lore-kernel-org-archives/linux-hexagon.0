From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: get rid of #include <generated/compile.h>
Date: Wed, 27 Sep 2017 18:24:15 -0500
Message-ID: <20170927232415.GB5939@codeaurora.org>
References: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1506554658;
        bh=Nc8dSOXJMjgyEip/RaDUmkfvWJ6FqF6beyYsMH2ZyCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOYjPTqXc+QwQniwmP8g7Mwn2si2hd/3LqNL4JLiRQKCBGDK12mWOb6yc5RPynD2D
         8AnN6+DghvBfAFyB/qsLQONLVhdAePqQ0w1X7tPT40ptuXAQSgXAmw/A0kq1eTpBfx
         6w2BJ7uJtk3giAXfNWT/SK5BA1cRnAYk8K/6iZz4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1506554658;
        bh=Nc8dSOXJMjgyEip/RaDUmkfvWJ6FqF6beyYsMH2ZyCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOYjPTqXc+QwQniwmP8g7Mwn2si2hd/3LqNL4JLiRQKCBGDK12mWOb6yc5RPynD2D
         8AnN6+DghvBfAFyB/qsLQONLVhdAePqQ0w1X7tPT40ptuXAQSgXAmw/A0kq1eTpBfx
         6w2BJ7uJtk3giAXfNWT/SK5BA1cRnAYk8K/6iZz4=
Content-Disposition: inline
In-Reply-To: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-hexagon@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org

On Thu, Sep 21, 2017 at 12:17:50AM +0900, Masahiro Yamada wrote:
> <generated/compile.h> is created (or updated) when Kbuild descends
> into the init/ directory.  In parallel building from a pristine
> source tree, there is no guarantee <generated/compile.h> exists when
> arch/hexagon/kernel/ptrace.c is compiled.
> 
> For hexagon architecture, we know UTS_MACHINE is a fixed string
> "hexagon", so let's hard-code it, like many architectures do.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/hexagon/kernel/ptrace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
