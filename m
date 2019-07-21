From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESEND PATCH v2 06/14] hexagon: switch to generic version of pte allocation
Date: Sun, 21 Jul 2019 09:53:31 -0700
Message-ID: <CAHk-=whbd8UWeX-O-Zpn5iKdC6YMxef9UuH3R=TL14W5N86h0g@mail.gmail.com>
References: <20190721141914.GD26312@rapoport-lnx>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5u5pYqXEq+IeJ5qYP8FGZejReb4Nr/dgdEELXviWuQ=;
        b=SfsRifqu+/ZSthpm4gGscjWytOn4AblnNEKGWQiyBnd3PO0tY2AUD1Dw9bLJkXVq6l
         bi7L001ejkx8PoKwPhLRRscBLevCouzWJTl1UCqvNgOy0GG+3IBFVFZSuRizDg6/6ob+
         yCDdDMR+6ZXuFfvVtmBzj0aLDjFeTHeOeokhY=
In-Reply-To: <20190721141914.GD26312@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>

On Sun, Jul 21, 2019 at 7:19 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> I understand that merge window is going to close in couple of hours, but
> maybe this may still go in?

Applied.

              Linus
