From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Thu, 1 Jun 2023 12:27:30 +0200
Message-ID: <CANiq72nf-MC36hHzv0ZpR+qUyaf3mhF+rfqpMcVbw0AheuRBpA@mail.gmail.com>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com> <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com> <87ilc8ym6v.fsf@mail.lhotse>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685615261; x=1688207261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+7FpAWqJ9UaTJolR3fhX+VLULajdYAdz5DrVldjg9M=;
        b=DNPDU5955K3+hJXFzOhvILPyfqhiSdd9AH82pxA7AZjcBYekzjwTVcHeYa5kxirgAO
         Zsqg9Mg7i09PWZMBkKR7GAnp8ApHEPR/Ngb4zXdIsbHhJ2yHMUtuKsa+hA1WMlIBXDaZ
         f5aECL2Gh3Xr5TOs0ItqQjUOT/xZD07F4DerYW8MthBWzV1iasujQH82WKNARh7GgVhv
         RGxSnQJpSYab1qYmx8r7cey9siNoVykynMlqHekdt4eUUPcU8QbgHsus2PuNMBfIFJIn
         wbOdnSrHZ8yKkEnZAa8jCXmmAosVEa2dhbK92w49HB5Bxw4jMYLpapeOHTgKpe+O3OCV
         jJwQ==
In-Reply-To: <87ilc8ym6v.fsf@mail.lhotse>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="windows-1252"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: nathanl@linux.ibm.com, bcain@quicinc.com, keescook@chromium.org, gary@garyguo.net, pmladek@suse.com, linux-hexagon@vger.kernel.org, ustavoars@kernel.org, linux-kernel@vger.kernel.org, ojeda@kernel.org, wedsonaf@google.com, npiggin@gmail.com, alex.gaynor@gmail.com, Maninder Singh <maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>, linuxppc-dev@lists.ozlabs.org

On Thu, Jun 1, 2023 at 4:02=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
>
> > Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
> > used, but the name seems discarded? Can
> > `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
> > usage of the buffer there to begin with?
>
> A few lines below it uses the modname, and AFAICS there's no (easy) way
> to lookup the modname without also looking up the name.

Hmm... I think you are looking at the `xmon_print_symbol()` one? I was
referring to the `get_function_bounds()` one, where the `modname`
parameter is `NULL` (and the `name` contents are not used, only
whether it was found or not).

> > Side-note 2: in `scanhex()`, I see a loop `i<63` using `tmpstr` which
> > then is used to do a `kallsyms_lookup_name()`, so I guess symbols
> > larger than 64 couldn't be found. I have no idea about what are the
> > external constraints here, but perhaps it is possible to increase the
> > `line` buffer etc. to then allow for bigger symbols to be found.
>
> Yeah that looks wrong. I don't see any symbols that long in current
> kernels, but we should fix it.
>
> Thanks for looking.

My pleasure!

Cheers,
Miguel
