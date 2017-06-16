From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 11/35] hexagon: defconfig: Cleanup from old Kconfig
 options
Date: Thu, 15 Jun 2017 19:22:18 -0500
Message-ID: <20170616002218.GC7343@codeaurora.org>
References: <20170608160836.12196-1-krzk@kernel.org>
 <20170608161049.12421-11-krzk@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572540;
        bh=mn/bnEhbWJQr/yt4UJVV/AOgKPETRehSY4qfKVAR4Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bic6/M/52aUgfaodrzQ4C4OEy64jjrfEKkWlqBheBosc2+dTXklifBrnaeRDk0P+F
         Uw0Msf8kdNf60Zo+1Mp31t7Ecsxgi7UVJKnLtXkFN2834lGWHl6c970U5PIQ/xU9Re
         pu7h5Qzog5M4sns6P2A+VCk2rk4s2hEV1Ux1CgMs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572540;
        bh=mn/bnEhbWJQr/yt4UJVV/AOgKPETRehSY4qfKVAR4Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bic6/M/52aUgfaodrzQ4C4OEy64jjrfEKkWlqBheBosc2+dTXklifBrnaeRDk0P+F
         Uw0Msf8kdNf60Zo+1Mp31t7Ecsxgi7UVJKnLtXkFN2834lGWHl6c970U5PIQ/xU9Re
         pu7h5Qzog5M4sns6P2A+VCk2rk4s2hEV1Ux1CgMs=
Content-Disposition: inline
In-Reply-To: <20170608161049.12421-11-krzk@kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org

On Thu, Jun 08, 2017 at 06:10:22PM +0200, Krzysztof Kozlowski wrote:
> Remove old, dead Kconfig options (in order appearing in this commit):
>  - EXPERIMENTAL is gone since v3.9;
>  - NETDEV_1000 and NETDEV_10000: commit f860b0522f65 ("drivers/net:
>    Kconfig and Makefile cleanup"); NET_ETHERNET should be replaced with
>    just ETHERNET but that is separate change;
>  - HID_SUPPORT: commit 1f41a6a99476 ("HID: Fix the generic Kconfig
>    options");
>  - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/hexagon/configs/comet_defconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
