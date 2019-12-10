From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] hexagon: work around compiler crash
Date: Mon, 9 Dec 2019 17:36:16 -0800
Message-ID: <CAKwvOdkbTMj92Hj7Z2ucbJY5B_AZgANZhNoeOa2Taa2YTbCQUg@mail.gmail.com>
References: <20191028155722.23419-1-ndesaulniers@google.com> <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/ArZYKEfjZPBsRcDlrm2bJB7ahGFDYf0VWt4hD0Qjo=;
        b=Tr+C241trD4TLlSStYX0RZ2/acmkFLvu/V66NWO68Pgsjf+UXw0F/g4w5jP4u51yTC
         Ka81WTRlzO2b1a8sGcma60AQvixKXlL7KWoi6ioZNPudCQab6TFW6nUrh4JeHRDj9gXh
         jHxeDC9kvh98tdCZUT8ahK2e3j/ZXtpOgvR/f2SuLRXgab7OWEEIakRHl+jLVpbYHZEK
         nnTSJJq8shG8KCZGbycub0bPoZPxZ0Aultof8x7cY01uY/eSpqT4qdfOren6OUSnshlu
         2WIPjFk7VeawrmvbAc3wFL3CU0N0IJnMQaqxn/d63coWAiw8xt7UWz7Y9XqXe6igj/Dq
         3xIQ==
In-Reply-To: <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sid Manning <sidneym@quicinc.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, bcain@codeaurora.org

+ akpm, looks like you're picking up hexagon patches? Would you mind
please grabbing this one, too?

On Mon, Oct 28, 2019 at 1:09 PM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> > owner@vger.kernel.org> On Behalf Of Nick Desaulniers
> ...
> > Subject: [PATCH] hexagon: work around compiler crash
> >
> > Clang cannot translate the string "r30" into a valid register yet.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/755
> > Suggested-by: Sid Manning <sidneym@quicinc.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> LGTM.  Thanks, Nick.
>
> Reviewed-by: Brian Cain <bcain@codeaurora.org>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/002301d58dcb%24a9ffaa80%24fdfeff80%24%40codeaurora.org.



-- 
Thanks,
~Nick Desaulniers
