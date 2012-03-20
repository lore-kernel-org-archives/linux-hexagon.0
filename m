From: Kautuk Consul <consul.kautuk@gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault handlers.
Date: Tue, 20 Mar 2012 09:34:41 -0400
Message-ID: <CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
	<CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b0qNdX0yYfnSlRMkhERgTvE1hY1wGavI9my0tByerlI=;
        b=pXs8KAqpnr2F2QW2NUoH0Oez+UGVR2o4L/Bo8Jb3jXJEP3Z6gSbsSRByUnd9tFeCU5
         HcqldeIxaly6OaBpTl5UImLs9K9gBu2gXz875hlnikr1ImJpUBoAFiFidUKnbOOkTfoy
         ahNBS1lsM/Pgv1cBvTizYeEF87nPBRYbFjOT23TE7iFqAxDr1wqpuKgYIvrITIiCnV+h
         4Jn4dvA3A1jCWaacHqZsiRKV6NBPTNhLhsYf7j2Jia++o/MisREyMo+1LXos6A5DDgNg
         ea0mXMgtkM0RLSGjHwBHjyGIihFgULrXoVvh1SNFbW+FeAzVG9prTWiY351SU9yiSHgJ
         NHug==
In-Reply-To: <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@lists.openrisc.net, linux-am33-list@redhat.com, microblaze-uclinux@itee.uq.edu.au, linux-m68k@lists.linux-m68k.org, linux-m32r-ja@ml.linux-m32r.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

>
> What about arch/um/?
> Does UML not need this change?

Oh yes, extremely sorry I accidentally missed that one out.
Mind if I send it separately ?

>
> --
> Thanks,
> //richard

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
