From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 07/23] hexagon/time: Migrate to new 'set-state' interface
Date: Tue, 21 Jul 2015 17:28:51 -0500
Message-ID: <20150721222851.GB29874@codeaurora.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
 <519cb907e596d13b9f1e3fd1ee689acbbbeb56c7.1437044517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <519cb907e596d13b9f1e3fd1ee689acbbbeb56c7.1437044517.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Thu, Jul 16, 2015 at 04:56:19PM +0530, Viresh Kumar wrote:
> Migrate hexagon driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> We weren't doing anything in the ->set_mode() callback. So, this patch
> doesn't provide any set-state callbacks.
> 
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/hexagon/kernel/time.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 

Hexagon bits look fine to me, thanks!

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
