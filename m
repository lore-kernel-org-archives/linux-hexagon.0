From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 14:54:57 +0200
Message-ID: <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com> <20230529111337.352990-2-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451309; x=1688043309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EExUiqYGPAGs+gsix048NKVSDGe99d7YwmeqIwl9rU=;
        b=JtxDIm0lWrfYqXp1uWdsfFKWSgbbZ22HNue1yFm4trGTkGFo6xIWrEoI8KhdELLQIq
         DmECGu2waVpow6RkIqk3AX5YTN81bUQ38ACduEbGqRhLkcS4+aytN0jtUfSloYRWKQ+q
         vJ0J2K3/U3iSTAnBLpcaJBTIDJ4PsFSVRybdG1dxrRnsgqT6D7gFv8MPH9l+nYqEATRm
         /oGzvXMzw4aKlZlJX/qsd02+8TlbqEw/84uUqvj61DTDFGSAJGYrjrf8E1nbueJLbm4u
         AlOHw1376rAI3yUYgvk4ZhWGkPLuPeKI/Fb1pBA5e3XSOjJHmY7DC3vI1uRZ8RBpw1hF
         J/rw==
In-Reply-To: <20230529111337.352990-2-maninder1.s@samsung.com>
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
To: Maninder Singh <maninder1.s@samsung.com>
Cc: nathanl@linux.ibm.com, bcain@quicinc.com, keescook@chromium.org, gary@garyguo.net, pmladek@suse.com, ustavoars@kernel.org, linux-kernel@vger.kernel.org, Onkarnath <onkarnath.1@samsung.com>, wedsonaf@google.com, npiggin@gmail.com, alex.gaynor@gmail.com, linux-hexagon@vger.kernel.org, ojeda@kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, May 29, 2023 at 1:14=E2=80=AFPM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> +static char tmpstr[KSYM_NAME_LEN];

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
used, but the name seems discarded? Can
`kallsyms_lookup_size_offset()` be used instead, thus avoiding the
usage of the buffer there to begin with?

Side-note 2: in `scanhex()`, I see a loop `i<63` using `tmpstr` which
then is used to do a `kallsyms_lookup_name()`, so I guess symbols
larger than 64 couldn't be found. I have no idea about what are the
external constraints here, but perhaps it is possible to increase the
`line` buffer etc. to then allow for bigger symbols to be found.

Cheers,
Miguel
