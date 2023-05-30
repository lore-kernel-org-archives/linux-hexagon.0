From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 10:06:07 +0200
Message-ID: <ZHWub0ibU7etLnXK@alley>
References: <20230529052821.58175-1-maninder1.s@samsung.com>
 <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
 <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
 <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
 <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685433969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukbl4q0oH8kV5ZgAOr0o4FI9d9WKzL+MxA+Kz6z5tX8=;
        b=Ki27RLJOVorsjFnZmsstxVVQLhIFGev9cVJFWAktH3fgZ0qOHDJ9BvIxzHbCJQy82azP4J
        ZU8IGGZx7BvXTz+b986cSjh9v5EdcOPRMy3+dezyb5lUdXdAsFq0U/0oz3Tipcf7TG2jIN
        R8qZHj8zF2i2u7kdJP0/H2YRf/vncdY=
Content-Disposition: inline
In-Reply-To: <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maninder1.s@samsung.com, "keescook@chromium.org" <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Onkarnath <onk>

On Mon 2023-05-29 16:50:45, Miguel Ojeda wrote:
> On Mon, May 29, 2023 at 1:08=E2=80=AFPM Maninder Singh <maninder1.s@samsu=
ng.com> wrote:
> >
> > I Will add co-developed-by` tag.
> > because this change was identified while we were working on kallsyms so=
me time back.
> > https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/
> >
> > this patch set is pending and we will start working on that again, so i=
 thought better
> > to send bugfix first.
>=20
> Sounds good to me!
>=20
> (Fixed Wedson's email address)
>=20
> > Yes, I think second buffer was not related to kallsyms, so I have not t=
ouched that.
>=20
> Kees: what is the current stance on `[static N]` parameters? Something li=
ke:
>=20
>     const char *kallsyms_lookup(unsigned long addr,
>                                 unsigned long *symbolsize,
>                                 unsigned long *offset,
>     -                           char **modname, char *namebuf);
>     +                           char **modname, char namebuf[static
> KSYM_NAME_LEN]);
>=20
> makes the compiler complain about cases like these (even if trivial):
>=20
>     arch/powerpc/xmon/xmon.c:1711:10: error: array argument is too small;
>         contains 128 elements, callee requires at least 512
> [-Werror,-Warray-bounds]
>             name =3D kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
>                  ^                                           ~~~~~~
>     ./include/linux/kallsyms.h:86:29: note: callee declares array
> parameter as static here
>             char **modname, char namebuf[static KSYM_NAME_LEN]);
>                                  ^      ~~~~~~~~~~~~~~~~~~~~~~
>=20
> But I only see 2 files in the kernel using `[static N]` (from 2020 and
> 2021). Should something else be used instead (e.g. `__counted_by`),
> even if constexpr-sized?.
>=20
> Also, I went through the other callers to `kallsyms_lookup` to see
> other issues -- one I am not sure about is `fetch_store_symstring` in
> `kernel/trace/trace_probe_tmpl.h`. Steven/Masami: is that "with max
> length" in the function docs enough? Is it 0xffff?

The best solution would be to pass the buffer size as an extra
parameter. Especially when some code passes buffers that are
allocated/reserved dynamically.

Sigh, I am not sure how many changes it would require in kallsyms
API and all the callers. But it would be really appreciated, IMHO.

Best Regards,
Petr
