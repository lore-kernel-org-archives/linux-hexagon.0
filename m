From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: hexagon: signal handling bugs
Date: Wed, 15 Feb 2012 12:18:07 -0600
Message-ID: <CAHrUA35E=0bfbe=4NS5FUcGqSGv-OEhP_6DM4+K4E1or9FyhdA@mail.gmail.com>
References: <20110817163457.878854582@codeaurora.org> <20110817163521.165013232@codeaurora.org>
 <20120211232740.GM23916@ZenIV.linux.org.uk>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=nOt4Y4TX2QhEP7Fvx/RXUBDvVhftZ+uSvRGoddo8NNo=;
        b=oZ8U2xLx9F+29Cdq46YSOtMaR/s0n8+coJqzR2w9YZzD9dLsiUuHppEznnPm/XCMvV
         S3i9y/YDJMm2z0dZTI2TrpWQ5pKitPd/V6RebngvSl6jvsljmI/KX570eokvyMcqQHtO
         QVzESoGKRwcmxjI088Q+OrDAwUaFOTF6TR3nY=
In-Reply-To: <20120211232740.GM23916@ZenIV.linux.org.uk>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 11 February 2012 17:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A01) unless I'm seriously misreading hexagon=
 vm_entry.S, once we'd
> called do_notify_resume, we do *not* recheck if there's more work to
> be done.

> =C2=A0 =C2=A0 =C2=A0 =C2=A02) sigreturn should *NOT* be restartable a=
t all, or you'll get
=2E...

Is there an architecture that "does this best"?  I (re-)wrote a
significant part of the hexagon sig-handling code, and I did it via
"surgical hacking": by reading the code for 4-6 other arches, and
trying to pick out the "best practices" of each.  But its easy to
build a Frankenstein when using body parts from mis-matched places, so
perhaps many of these mistakes were mine...

Perhaps its desirable to modify most/all architectures, so as to evoke
more commonality?  Some of the other, more minor arches sure did look
incomplete to me...

-- Linas
