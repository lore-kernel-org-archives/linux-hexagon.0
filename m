From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sat, 23 Feb 2013 18:24:47 -0600
Message-ID: <CAHrUA36Gz458YfwXYT3tWJUEBCq1dwsg=Lf6B2Tg8puc_rO61A@mail.gmail.com>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:from:date:message-id:subject:to
         :content-type;
        bh=qGCFuH0QiptFRhwutAvcnovfRl2AGDYM4r17iNfU/C0=;
        b=i3YOA4iIOL70kOGUq14NUrOHdXmQ4WAS1nptzHyUGdbBEXf2nErippabXWMGsEkngP
         F2L9luQGnGuAN9xWD7h6DzslFrFqa10By9TVio2sghxjiupDn5M8lp6h0Py033JNZF0e
         scAFWQFhFbdpTcIGjDR+/QK9mJkcFGPXNZgZy40DxL5ottEIBs1rh+bUcSzORCYpfkwU
         DbFw6UKCqsK9gTczw0C6Xkk9n5CUXu5ODsKl3Q/ffTOaGj7dCqeMqqDkzW39HwpltLkc
         COMEdKW2WBMSNHoCTwGuFN8icl5p6K65f2Xb6o8rWZ4QQWa3NLSnlS5JZnV4C2meyyt2
         NUzg==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org, cotulla <cotulla@yandex.ru>

On 19 February 2013 19:17, <cotulla@yandex.ua> wrote:
>
> Does every thread starts execute exception handler or only one, selected
> by hardware?
>
Only one, I believe, But its 'random' as to which one.

> How preemtion is disabled in that case?
>
? I believe interrupts are disabled upon entry to the exception handler.
 You have to re-enable them when you are ready, with I'm guessing ciad,
don't remember how this worked.  Each thread has its own local mask too.

There are like 4 or 5 or 6 bits that need to be set/cleared for interrupts
to be handled: there's a global bit to enable any interrupt. There's a
global mask to enable interrupts of a given priority, there's a local,
per-thread mask of the same.  There's an exception bit which is cleared by
return-from-exception.   I think there's one more bit, I can't remember.

>
> 2. What difference between ciad and cswi?
> I guess ciad is "Clear Interrupt Ask Done" and cswi is "Clear SoftWare
> Interrupt"?
>

There is a 'software interrupt' which allows one core to interrupt another.
 I think  cswi would be to clear those.

--linas
