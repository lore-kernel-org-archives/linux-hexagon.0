From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] Hexagon: Delete stale barrier.h
Date: Thu, 1 May 2014 09:10:05 -0700
Message-ID: <20140501161005.GA6212@roeck-us.net>
References: <1397808515-8013-1-git-send-email-vgupta@synopsys.com>
 <1397808515-8013-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=heiPV2CADNn2qWQjGe4jEe31a4iX8teb8fJNWXk7IIg=;
        b=0L0bZACcSthE4PzaHPm7NWbTMzU/9bekreXrMzsB21mWvBkKkSK7GMQGwV+N6qMW5v
         K6NhvjtPfxBAgYsTrz+JkBzz5odx1htdMDfXK8jsrRxi+cfTlw+dTl/ubt1Mwxv1/430
         9VHJns4NUHQMQJeAk+pz6rBrZT16t85haw7fCMiFIkgFXDyjJAr/zcFTH2qL2tMWXD2X
         4IkfhaSH5h5nUpAqB4vZzoNDB5n3HrLNmsCvp0blu+6nMGRH2VShiR1JgzjCoKey7uDK
         IRPkVHRDtLBzQSvwa/iBn82WzPG7p9hH6kzPVkFMFUDA47FCxwuTMbxOT2HiM2xPRQpv
         0+ig==
Content-Disposition: inline
In-Reply-To: <1397808515-8013-3-git-send-email-vgupta@synopsys.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Fri, Apr 18, 2014 at 01:38:35PM +0530, Vineet Gupta wrote:
> It is likely Hexagon build is broken too in 3.15.
> But I don't have a working compiler to be sure.
> 
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Hexagon build is still broken with 3.15-rc3 and with the latest upstream.
This patch fixes the (build) problem. Would be great if the arch maintainer
could apply this (or a similar) patch and send it to Linus.

Compile-tested-by: Guenter Roeck <linux@roeck-us.net>
