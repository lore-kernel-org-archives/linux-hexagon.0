From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH 0/3] Cleanup raw handling of online/possible map
Date: Tue, 14 Feb 2012 14:49:41 -0800
Message-ID: <1329259784-20592-1-git-send-email-venki@google.com>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=yOhserrUfvkY3ZIJV3xIijVCgGVNyG2k9fouDdZjnZU=;
        b=wXjRMQrcRlvP18w5yv/Nnie/YSIPcaUazUGD35WW280QmzLqWaH9MwmCL9E+qhzxoG
         kfCVhuudaBpOtVIehr2zKS3uduYgdhirqQSx96NH6AnfUr3q7dk+SUm5l4Lz3ZHjU2kE
         Gu31lQOFEzY5JBWHt2ImGdox896QzAd5VodD8=
In-Reply-To: <87wr7pbwbz.fsf@rustcorp.com.au>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tony Luck <tony.luck@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Mike Travis <travis@sgi.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

> Yes, and the other architectures.

Here are the patches for other instances I see in plain git grep.

I have been brave (foolish) enough to send this without any testing. So,
this comes with 'use it at your own risk' tag :-).

Thanks,
Venki
