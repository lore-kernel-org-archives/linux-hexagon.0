From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault handlers.
Date: Tue, 20 Mar 2012 14:36:06 +0100
Message-ID: <CAFLxGvyVbDndbu_2ZbUBwbrJCq+d4rRZW0ROxTpQxAvetRm=0w@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
	<CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
	<CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <owner-linux-mm@kvack.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z8vsK81CygBIuHX16jyNJHAJj27uKl4lPGrdmm5sdCc=;
        b=Un0MNinOAKV7X1eDc/Osjv1V4bvQULSASOrucHPQuSNXckMJDmLUc9OAZDnX2JtepB
         tRLcQh2wiwCQ6EUZy6hToHExuu5QEV8A+rR5o87jRqlRjGJHeNncM9A/SpNsZ6H/3BDP
         OWJxJEj0vFXQND6mMN1GoUlTjIWPK8238QgKZpsanOaphnLZebUVgCOSS1F4K09epa7T
         vPJyekeVu8fr1jWiaGfonnXUGbIv7mw1mYa+n8Oy8ytgS6h4HAIroqSGkEs+g13xDXN4
         wxR9VYXfIq11oa8Lb608XgV97bOeORf18J9RfZgHJeijIZ80Gp+KIZqfb4bWeUHpWkwD
         wqfg==
In-Reply-To: <CAFPAmTSzV9mrkbP68p4PA-0i0o2Hz7JiBY=0A0V_myJEzWubjQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@lists.openrisc.net, linux-am33-list@redhat.com, microblaze-uclinux@itee.uq.edu.au, linux-m68k@lists.linux-m68k.org, linux-m32r-ja@ml.linux-m32r.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Mar 20, 2012 at 2:34 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
>>
>> What about arch/um/?
>> Does UML not need this change?
>
> Oh yes, extremely sorry I accidentally missed that one out.
> Mind if I send it separately ?

No problem.
handle_page_fault() is the function you want to patch. :)

-- 
Thanks,
//richard

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
