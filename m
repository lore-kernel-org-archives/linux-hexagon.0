From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 03/36] Hexagon: Add bitops support
Date: Fri, 26 Aug 2011 22:34:10 +0200
Message-ID: <20110826203410.GB6630@ucw.cz>
References: <20110817163457.878854582@codeaurora.org>
 <20110817163520.145693358@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110817163520.145693358@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Hi!

> +	__asm__ __volatile__ (
> +	"	{R10 = %1; R11 = asr(%2,#5); }\n"
> +	"	{R10 += asl(R11,#2); R11 = and(%2,#0x1f)}\n"
> +	"1:	R12 = memw_locked(R10);\n"
> +	"	{ P0 = tstbit(R12,R11); R12 = clrbit(R12,R11); }\n"
> +	"	memw_locked(R10,P1) = R12;\n"
> +	"	{if !P1 jump 1b; %0 = mux(P0,#1,#0);}\n"

Nice assembly syntax, btw. I can only wish architectures such as arm
used something as readable...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
