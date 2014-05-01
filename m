From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Hexagon: Delete stale barrier.h
Date: Thu, 1 May 2014 10:10:24 -0700
Message-ID: <CA+55aFwCOW+bZHfAYMJsFQqEiX7bE79B-JwcJxZ67UVtEQgpcA@mail.gmail.com>
References: <1397808515-8013-1-git-send-email-vgupta@synopsys.com>
	<1397808515-8013-3-git-send-email-vgupta@synopsys.com>
	<20140501161005.GA6212@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8nydwxBdifgN8RccvJdCZZwwq7plgz/8HMHG5/RT0ck=;
        b=jufs/WHyPhCsq0EVT9UySMrFo3fZpAtMReBOlCc1In9LxhWsXHjShF06/nY/LSOjlo
         bT/GAAAIaEI8/U1H49+8uGl3qnsgxUptUyKfWI2Wz6ni5eI0rG1dnZ547EEBC0DCRvzB
         cE+dZEJSbLN0zrQ0ITri35yBCwnXP2vt5P9Akf+VOnK/LHEYBfYAJUNAfSXVB1dYxJo3
         ClNTEF9LTBQ/f5vpjx4Nwc+Wsm8MwmwwoFdqVygZXJVTFcEaZomtntwVfLtvgRoavLyj
         J/AaVj7V/8iP7VnJeSuyEJymGZ/RlKswlL72qnHt9l4t0VHlJaIDpmQ42u7sjSQirtA8
         J5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8nydwxBdifgN8RccvJdCZZwwq7plgz/8HMHG5/RT0ck=;
        b=TSVMg6VV+0DK8uA+Dw5WeFj4o27VMiZME76VJaxd8MA+CDaXTfNrMlWWipKb3rvQzs
         qyJLThsi62/gXjprBFjVusSCb2u5mZ4LPs8OFsTUq7jclRsUlBY/VdSrMhavzwbPgdB3
         9bqTQ0Q7zuYUYT2zFwS4aO7UvIzw90PKiHpAM=
In-Reply-To: <20140501161005.GA6212@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On Thu, May 1, 2014 at 9:10 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hexagon build is still broken with 3.15-rc3 and with the latest upstream.
> This patch fixes the (build) problem. Would be great if the arch maintainer
> could apply this (or a similar) patch and send it to Linus.

I took it directly, since you compile-tested it.

             Linus
