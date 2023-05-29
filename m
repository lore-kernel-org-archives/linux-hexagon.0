From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Date: Mon, 29 May 2023 16:50:45 +0200
Message-ID: <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
References: <20230529052821.58175-1-maninder1.s@samsung.com>
 <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
 <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com> <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685371857; x=1687963857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkEVYGTJUZLFC58767MzB3G1DJSBq+gVyG1W6RWmlbg=;
        b=OmhRTIWKrDsYJ3rUntEtfxHtHZFmjJNL/2Y9uhSCFac/J5jZcmQRgSWBb5S2LQ2mdh
         duMLDq7I6cBIR9Ck7Ohj7Gpe0ETo+iNl7otudyBpDBu+drz/siEmGBPqVIHbDhUCHtX6
         4SZkVCbgKpfU+p25VNSqPYJz93dhEiAv4cPsWu8zkiu1xRWPY3GypqjaAwT1eVqXinwn
         +Fsy/NIZeOxwdvvxZBQdiVQn4k64Frn/315+u+Gbx9DDK6JEk5cwmvbiRHl92rhcCEjK
         ceaBdsANLZWN3eYRfz/T6+azlqxVPxCsX9tNkhGLg5G34XxO1ry1YjaVIvy7cC47vLwJ
         XLkA==
In-Reply-To: <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: maninder1.s@samsung.com, "keescook@chromium.org" <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Onkarnath <onkarnath.1@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>

On Mon, May 29, 2023 at 1:08=E2=80=AFPM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> I Will add co-developed-by` tag.
> because this change was identified while we were working on kallsyms some=
 time back.
> https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/
>
> this patch set is pending and we will start working on that again, so i t=
hought better
> to send bugfix first.

Sounds good to me!

(Fixed Wedson's email address)

> Yes, I think second buffer was not related to kallsyms, so I have not tou=
ched that.

Kees: what is the current stance on `[static N]` parameters? Something like=
:

    const char *kallsyms_lookup(unsigned long addr,
                                unsigned long *symbolsize,
                                unsigned long *offset,
    -                           char **modname, char *namebuf);
    +                           char **modname, char namebuf[static
KSYM_NAME_LEN]);

makes the compiler complain about cases like these (even if trivial):

    arch/powerpc/xmon/xmon.c:1711:10: error: array argument is too small;
        contains 128 elements, callee requires at least 512
[-Werror,-Warray-bounds]
            name =3D kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
                 ^                                           ~~~~~~
    ./include/linux/kallsyms.h:86:29: note: callee declares array
parameter as static here
            char **modname, char namebuf[static KSYM_NAME_LEN]);
                                 ^      ~~~~~~~~~~~~~~~~~~~~~~

But I only see 2 files in the kernel using `[static N]` (from 2020 and
2021). Should something else be used instead (e.g. `__counted_by`),
even if constexpr-sized?.

Also, I went through the other callers to `kallsyms_lookup` to see
other issues -- one I am not sure about is `fetch_store_symstring` in
`kernel/trace/trace_probe_tmpl.h`. Steven/Masami: is that "with max
length" in the function docs enough? Is it 0xffff?

Thanks!

Cheers,
Miguel
