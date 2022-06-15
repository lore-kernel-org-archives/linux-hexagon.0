From: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Date: Wed, 15 Jun 2022 10:01:57 +0200
Message-ID: <YqmR9ZeiwMQLyKDu@alley>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
 <YonTOL4zC4CytVrn@infradead.org>
 <202205231238.FAF6D28@keescook>
Mime-Version: 1.0
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655280119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaM9M2rnjrvdQGQ7RvZB3kRvN0KL8OK3uY7jsfFlhwM=;
        b=qRtiw/EwzIsZzY7D7oh0BeOfU6iIQ38xDbUtfQXTtdaPPWK3B2vJeEb6IIHEt7MxZ3zKcC
        dfyx4Mc4tIb/eF0FliF28q8hNk+hU2TEYFUekYuM8cDMqgo0Awx7lmNgOzPGeK/9Q2qhBN
        CjKBFgcYgu+XVY7XBl81AW22w0F/oCg=
Content-Disposition: inline
In-Reply-To: <202205231238.FAF6D28@keescook>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maninder Singh <maninder1.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, bcain-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, hca-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, gor-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, agordeev-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, borntraeger-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, svens-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, satishkh-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, sebaddel-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, kartilak-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason.wessel-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, naveen.n.rao-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, boqun.feng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, senozhatsky-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org

On Mon 2022-05-23 12:39:12, Kees Cook wrote:
> On Sat, May 21, 2022 at 11:07:52PM -0700, Christoph Hellwig wrote:
> > On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> > > kallsyms functionality depends on KSYM_NAME_LEN directly.
> > > but if user passed array length lesser than it, sprintf
> > > can cause issues of buffer overflow attack.
> > > 
> > > So changing *sprint* and *lookup* APIs in this patch set
> > > to have buffer size as an argument and replacing sprintf with
> > > scnprintf.
> > 
> > This is still a pretty horrible API.  Passing something like
> > a struct seq_buf seems like the much better API here.  Also with
> > the amount of arguments and by reference passing it might be worth
> > to pass them as a structure while you're at it.
> 
> Yeah, I agree. It really seems like seq_buf would be nicer.

There is a new patchset that is trying to use this kind of buffer
in vsprintf.

It introduces another buffer struct because vsprintf() needs a bit
different semantic than the one used in seq_buf. But it actually
replaces seq_buf() in the end. I am not sure if this is the right
approach.

Anyway, the initial API is very simple, see
https://lore.kernel.org/r/20220604193042.1674951-2-kent.overstreet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

And it makes the internal vsprintf() API more sane, see
https://lore.kernel.org/r/20220604193042.1674951-4-kent.overstreet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

It would eventually solve also concerns about the kallsysms API.
Any comments on the new printbuf API are much appreaciated.

Best Regards,
Petr
