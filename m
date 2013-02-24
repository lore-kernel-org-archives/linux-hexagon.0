From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sun, 24 Feb 2013 16:23:42 +0400
Message-ID: <1982671361708622@web15h.yandex.ru>
References: <1163031361018389@web26d.yandex.ru> (from cotulla@yandex.ua on
	Sat Feb 16 06:39:49 2013) <1361593470.29465.17@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361708623; bh=HaOAM6TW7lfV6/pvPH+pJkW/pJakDxdSPe2IoIQFlyo=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=scMOIk7OvN4TXu9filJNyaY2pxoyMkF0jtbOf5IyUoWZCP+b7cu+8aDXDH4KJU82C
	 vTk70Yp5W7waEE5w9gW/mR3LIBuujwApuhfSyxJ3z8wrCv1QN+H2FMT25pWcGiC32m
	 sDyQoVyW+aLVJYSIjpMY+i+Oa25MxCMheNOdAhaI=
In-Reply-To: <1361593470.29465.17@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org

This is our current boot log:

http://pastie.org/private/slkvwbykfu4txqc1bq51q

However there are a lot of debug output.
But at least it already reaches the end of user mode program which consist from:

 puts("Hello from linux");
 while (1);



-Cotulla
