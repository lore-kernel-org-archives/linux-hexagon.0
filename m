From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 04/18] arch: hexagon: Don't select HAVE_OPROFILE
Date: Fri, 15 Jan 2021 09:30:41 -0600
Message-ID: <003a01d6eb53$63313330$29939990$@codeaurora.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org> <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610724672; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=q0/ru+LfZr7L2kRVGdNGG4rvKSg/SVssCMScCzWIjSY=; b=L+IsKs8FwKx9jG3pS2hifEwVuvWvX3MyL+QBXbTVekZMD9FQzRf7Pt8AHlPxa99fWKBHBYBi
 vEciTf9FsE/MAlHaZplkQnKJmZHfefMa8LDJLO+NEOSGBWqzIupkiu4yozB8zxGQ9sDFlgXo
 gnJrZzDXEmdN+tn6m/Pl1iON0AQ=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Robert Richter' <rric@kernel.org>
Cc: 'Vincent Guittot' <vincent.guittot@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>, oprofile-list@lists.sf.net, 'William Cohen' <wcohen@redhat.com>, 'Alexander Viro' <viro@zeniv.linux.org.uk>, anmar.oueja@linaro.org, 'Christoph Hellwig' <hch@infradead.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Thursday, January 14, 2021 5:35 AM
...
> The "oprofile" user-space tools don't use the kernel OPROFILE support any
> more, and haven't in a long time. User-space has been converted to the
perf
> interfaces.
> 
> Don't select HAVE_OPROFILE for hexagon anymore.

Acked-by: Brian Cain <bcain@codeaurora.org>

> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/hexagon/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig index
> 6e00c16a36b5..44a409967af1 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -7,7 +7,6 @@ config HEXAGON
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_NO_PREEMPT
> -	select HAVE_OPROFILE
>  	# Other pending projects/to-do items.
>  	# select HAVE_REGS_AND_STACK_ACCESS_API
>  	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
> --
> 2.25.0.rc1.19.g042ed3e048af


