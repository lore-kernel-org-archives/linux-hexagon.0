From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon/time: make rtos_timer_device __initdata
Date: Wed, 27 Sep 2017 18:23:19 -0500
Message-ID: <20170927232319.GA5939@codeaurora.org>
References: <1505804841-20278-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1506554601;
        bh=JFP/FpinwsqEXuh4yH0ygGDqXEOjGpofKmXxrI5kywY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1KwFT46BEWTJ8tTv3/G4sM0zzTHpMHzvbQxEQquLlUZ5ZRU6tj17YfvE2zguk7fw
         FfWvZ6i3Sll1gJyUt5JdvRf1dgdCI4qGZcDDDThxzxHtoyyGoeoASUm8b5YrtlT/Hh
         CNOEZ6ZhHWO1PhycTCP/qzik68MsXLPeFPeSQTNE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1506554601;
        bh=JFP/FpinwsqEXuh4yH0ygGDqXEOjGpofKmXxrI5kywY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1KwFT46BEWTJ8tTv3/G4sM0zzTHpMHzvbQxEQquLlUZ5ZRU6tj17YfvE2zguk7fw
         FfWvZ6i3Sll1gJyUt5JdvRf1dgdCI4qGZcDDDThxzxHtoyyGoeoASUm8b5YrtlT/Hh
         CNOEZ6ZhHWO1PhycTCP/qzik68MsXLPeFPeSQTNE=
Content-Disposition: inline
In-Reply-To: <1505804841-20278-1-git-send-email-bhumirks@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 19, 2017 at 12:37:21PM +0530, Bhumika Goyal wrote:
> Make this __initdata as it is only modified during the init phase and
> after that the structure and its fields are not referenced anywhere.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> Hexagon architecture was not found while cross-compiling, so the
> file is not compile-tested. 
> 
>  arch/hexagon/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
