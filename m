From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 3/4] avr32: select ARCH_WANT_FRAME_POINTERS and set
 DEBUG_KERNEL in defconfigs
Date: Tue, 10 Nov 2015 07:43:08 +0100
Message-ID: <20151110064308.GA22108@samfundet.no>
References: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
 <1447096878-13519-4-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447096878-13519-4-git-send-email-yang.shi@linaro.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yang Shi <yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com

Around Mon 09 Nov 2015 11:21:17 -0800 or thereabout, Yang Shi wrote:
> FRAME_POINTER is set by default if ARCH_WANT_FRAME_POINTERS and DEBUG_KERNEL
> are  selcted, this is the standard way to include FRAME_POINTER used by all
> of other architectures.
> 
> And, set DEBUG_KERNEL=y in defconfigs otherwise FRAME_POINTER won't be enabled
> at all.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/avr32/Kconfig                                  | 1 +
>  arch/avr32/configs/atngw100_defconfig               | 1 +
>  arch/avr32/configs/atngw100_evklcd100_defconfig     | 1 +
>  arch/avr32/configs/atngw100_evklcd101_defconfig     | 1 +
>  arch/avr32/configs/atngw100_mrmt_defconfig          | 1 +
>  arch/avr32/configs/atngw100mkii_defconfig           | 1 +
>  arch/avr32/configs/atngw100mkii_evklcd100_defconfig | 1 +
>  arch/avr32/configs/atngw100mkii_evklcd101_defconfig | 1 +
>  arch/avr32/configs/atstk1002_defconfig              | 1 +
>  arch/avr32/configs/atstk1003_defconfig              | 1 +
>  arch/avr32/configs/atstk1004_defconfig              | 1 +
>  arch/avr32/configs/atstk1006_defconfig              | 1 +
>  arch/avr32/configs/favr-32_defconfig                | 1 +
>  arch/avr32/configs/hammerhead_defconfig             | 1 +
>  arch/avr32/configs/mimc200_defconfig                | 1 +
>  15 files changed, 15 insertions(+)

<snipp diff>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

-- 
Best regards, Hans-Christian Noren Egtvedt
