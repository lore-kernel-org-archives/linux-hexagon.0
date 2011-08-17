From: David Brown <davidb@codeaurora.org>
Subject: Re: [patch 32/36] Hexagon: Comet platform support
Date: Wed, 17 Aug 2011 13:08:30 -0700
Message-ID: <20110817200830.GB22064@huya.qualcomm.com>
References: <20110817163457.878854582@codeaurora.org>
 <20110817163522.852412019@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110817163522.852412019@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wed, Aug 17, 2011 at 11:35:29AM -0500, Richard Kuo wrote:

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-hexagon-kernel/arch/hexagon/configs/comet_defconfig	2011-07-20 15:19:44.785151291 -0500
> @@ -0,0 +1,873 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux/hexagon 2.6.39-rc5 Kernel Configuration
> +# Wed May  4 16:08:56 2011

This should be a shrunk defconfig.  If you 'make savedefconfig', it'll
make a shortened version of this file that will only contain fields
that are set to non-default values.  It reduces the amount of churn on
these files (and also just makes them a lot smaller).

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
