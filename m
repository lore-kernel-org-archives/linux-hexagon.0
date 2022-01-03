From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Reference to non-existing config COMET_EARLY_UART_DEBUG
Date: Mon, 3 Jan 2022 13:16:48 +0100
Message-ID: <CAKXUXMwcPLAAviuotom39+9m3upZvir-az=_-ZxU0eOu8OPxWA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lOyYQI0CIiGDaIpaEWbuQqbHJxkreGLXN8QH7/z8oI4=;
        b=avHPEGVXj896OQFF1OF8lCa7weuU688Bgnpm0I6pbYz1jMhNj2SDgNGAGsxgYOWx+c
         cpbaI+2zQm4NH4mEZp8vasOY2vT9Edc/3q82TLFpkKZxWA6McTVyivhnhlomW0gSZETH
         c/VZWKq2H5c5gEIo3cKElPBM179+Pq/ivqeFhTjEWKBR0QYsdk7PtUcXqxxNdFLl5fbe
         HC4xM3B/D6RSOJfP0r5Ky1dVi9E3oOY90BuvcNe59iqbvkxBcD7yKYZ0LNk6Km+UUyd+
         JmUg+t8XZi1bG73eHLaBasdU9dgEVq0npwkZbvcXTc2AdFM5khqDAru/yuHfS9FXsEWD
         GKig==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>

Dear Brian,

In arch/hexagon/kernel/vm_init_segtable.S, an ifdef refers to
CONFIG_COMET_EARLY_UART_DEBUG, but this config is never defined in the
Kconfig files.

Can we delete this dead code in
arch/hexagon/kernel/vm_init_segtable.S? If so, I will send a patch for
that.

Best regards,

Lukas
