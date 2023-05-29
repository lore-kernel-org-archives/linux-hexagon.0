From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Date: Mon, 29 May 2023 12:45:02 +0200
Message-ID: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
References: <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcas5p4.samsung.com>
 <20230529052821.58175-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357113; x=1687949113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjEDNzZxOop2VOG3TlruQByMALTvalbpgRkYicVySh8=;
        b=kO2I3xZBL5Fe6W44U6h5s0RTzUX1eBWFPWgeyLaB+aRoskBhW8J6xFuenfgi/xR6Wh
         IZRcy/wR/Zus7O3ZAFUC3RVR7HAr4Z3gzYddvxPIHRaxis8PczdXexDsOzSNucW1AIRp
         /3EXL3LfTJKYlHuuqeECSSOTiXyzytVrKZda+frNZ+aiXehejLzWaTlZyBMWCTdVQKOh
         p9+ACmhXzwYD/jXNtnBaaDnk+NV9rGfzojXroEzvf69Bao7ikkBVaSDJ5GdNbHSq1YKU
         D+LokY4GFBGAAmsFvdnP9eOuys0mkxoVRfOqLI2GmGtGeSd/DurcgCqC+JhBjSxOMyJO
         ZEWA==
In-Reply-To: <20230529052821.58175-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Maninder Singh <maninder1.s@samsung.com>
Cc: bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com, wedsonaf@google.com, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>

On Mon, May 29, 2023 at 7:44=E2=80=AFAM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for powerpc and hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to =
512")
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Thanks for this!

There is no `From:` at the top. Since I cannot locate the patch in
Lore, did you mean to put both of you as authors perhaps? In that
case, please use a `Co-developed-by` as needed.

Perhaps it is a good idea to submit each arch independently, too.

The changes themselves look fine on a quick inspection, though the
`xmon.c` one is a global buffer (and there is another equally-sized
buffer in `xmon.c` with a hard-coded `128` constant that would be nice
to clarify).

Cheers,
Miguel
