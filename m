Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D338A064
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 10:58:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A1E14B7FB;
	Thu, 20 May 2021 04:58:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZe2px36T1oY; Thu, 20 May 2021 04:58:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A46444B750;
	Thu, 20 May 2021 04:58:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AE694B83A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 12:57:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4p1uj6pvR6Gp for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 12:57:57 -0400 (EDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A63C24B832
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 12:57:57 -0400 (EDT)
Received: by mail-lj1-f171.google.com with SMTP id w15so16429269ljo.10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nXnRBFRSdAWxCxN1vjVIJlzYFA0xQryLk10gJy9ij6Q=;
 b=pS95ZLgayqQwxXeQu8ZyQ8ycWuDd16ElGeC0xgVYQUfHCnl9JqIwvNsLMVzYfpTn+u
 4ylD5YuNNMfyuo+nPoA6mEIO3YGuJw8E4wG16u8d2PGReQu3zyMBFOG9ta3vUoParUt6
 VBwXR6Hnm+iQwRnaU0ju2zrO6HTCf5g6XRrEE6GN7GeKRDvFqs8MA2sHf3MHccHnaFE6
 ORhUxGYQAZe4Mt2I3W23avCfWFCIsSeLgpToUJu3q8FEeX7qIfxWlQVpVKoxLVNKcUB2
 Ks0pVOb7sy0MIfXP21Iz0SORueBfNACFXhk9ZAJiTR3OgxcxbO7w5lPRXdyc8yjPaELJ
 4K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXnRBFRSdAWxCxN1vjVIJlzYFA0xQryLk10gJy9ij6Q=;
 b=T0PbW2ryCbHh+OghROiFDie8TAOoITG41MCXnS0n2OJ3HYAeJh55iv+m8Fayh8Hh95
 IXr94BAgN81lkhHzGr8sHvmw+QoX/2oax+BbSaYieBOwXbPDdjGrGusglSAB+H1Mj2XR
 vhbktatK1rSBFQUHRKZ+QN/lJ9e6XKYydAXPyOmkM5+GBXmU98HnE3q/qmYTsf5Dlm5n
 2cx/0FSpP5ZOjLU6CLjksV3QKAO3Khd/CsvirdZ53G8g08Q6dbfLcYXpVZOoburrXaqX
 fnFw0kLlBZzB0kg05JDzKfug6mqfLhqhi6z8HotyVSrytQcrMi4OjcfihLAMk512dgOl
 qT5Q==
X-Gm-Message-State: AOAM530NFxZSTbhXa5fbNOkjvuL/t/o9706KGyzLVORiZ6IenCGYB0qA
 RI9d5niOGsKgkdv21IEz1BoeHgTwpYJSe8O5mauIDw==
X-Google-Smtp-Source: ABdhPJzI+2nDatir7SSjGH9vGdaZ94OaqoLrJ65pr7UMe9dwtydU4yzOQkWodFVnPMXpww81DjPTXpOxM5ET8qLqvAo=
X-Received: by 2002:a2e:5d7:: with SMTP id 206mr151620ljf.448.1621443475884;
 Wed, 19 May 2021 09:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-4-jingzhangos@google.com>
In-Reply-To: <20210517145314.157626-4-jingzhangos@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 19 May 2021 09:57:29 -0700
Message-ID: <CALzav=e9iLLzZyccXq6gTM0nv6n=6qEUO+VYQ-RzJ44tNK30NQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] KVM: stats: Add documentation for statistics data
 binary interface
To: Jing Zhang <jingzhangos@google.com>
X-Mailman-Approved-At: Thu, 20 May 2021 04:58:01 -0400
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, May 17, 2021 at 9:25 AM Jing Zhang <jingzhangos@google.com> wrote:
>
> Update KVM API documentation for binary statistics.
>
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 171 +++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..9a6aa9770dfd 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,6 +5034,169 @@ see KVM_XEN_VCPU_SET_ATTR above.
>  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>  with the KVM_XEN_VCPU_GET_ATTR ioctl.
>
> +4.130 KVM_STATS_GETFD
> +---------------------
> +
> +:Capability: KVM_CAP_STATS_BINARY_FD
> +:Architectures: all
> +:Type: vm ioctl, vcpu ioctl
> +:Parameters: none
> +:Returns: statistics file descriptor on success, < 0 on error
> +
> +Errors:
> +
> +  ======     ======================================================
> +  ENOMEM     if the fd could not be created due to lack of memory
> +  EMFILE     if the number of opened files exceeds the limit
> +  ======     ======================================================
> +
> +The file descriptor can be used to read VM/vCPU statistics data in binary
> +format. The file data is organized into three blocks as below:
> ++-------------+
> +|   Header    |
> ++-------------+
> +| Descriptors |
> ++-------------+
> +| Stats Data  |
> ++-------------+
> +
> +The Header block is always at the start of the file. It is only needed to be
> +read one time after a system boot.

By system boot do you mean the host or the VM? If the host then it's
probably just cleaner to omit that part entirely and just say "It is
only needed to be read once.".

> +It is in the form of ``struct kvm_stats_header`` as below::
> +
> +       #define KVM_STATS_ID_MAXLEN             64
> +
> +       struct kvm_stats_header {
> +               char id[KVM_STATS_ID_MAXLEN];
> +               __u32 name_size;
> +               __u32 count;
> +               __u32 desc_offset;
> +               __u32 data_offset;
> +       };
> +
> +The ``id`` field is identification for the corresponding KVM statistics. For
> +KVM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For

Should this say "For VM statistics, ..." instead?

> +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> +"kvm-12345/vcpu-12".
> +
> +The ``name_size`` field is the size (byte) of the statistics name string
> +(including trailing '\0') appended to the end of every statistics descriptor.
> +
> +The ``count`` field is the number of statistics.
> +
> +The ``desc_offset`` field is the offset of the Descriptors block from the start
> +of the file indicated by the file descriptor.
> +
> +The ``data_offset`` field is the offset of the Stats Data block from the start
> +of the file indicated by the file descriptor.
> +
> +The Descriptors block is only needed to be read once after a system boot. It is

Ditto here about system boot.

> +an array of ``struct kvm_stats_desc`` as below::

Consider omitting these macros from the documentation, or moving them
to later. Readers right here are expecting to see the struct
kvm_stats_desc given the previous line.

> +
> +       #define KVM_STATS_TYPE_SHIFT            0
> +       #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SHIFT)
> +       #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> +
> +       #define KVM_STATS_UNIT_SHIFT            4
> +       #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SHIFT)
> +       #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> +
> +       #define KVM_STATS_SCALE_SHIFT           8
> +       #define KVM_STATS_SCALE_MASK            (0xF << KVM_STATS_SCALE_SHIFT)
> +       #define KVM_STATS_SCALE_POW10           (0x0 << KVM_STATS_SCALE_SHIFT)
> +       #define KVM_STATS_SCALE_POW2            (0x1 << KVM_STATS_SCALE_SHIFT)
> +       #define KVM_STATS_SCALE_MAX             KVM_STATS_SCALE_POW2

Terminology nit: I think usually this part is called the "base". e.g.
when you decompose a number X into N * B^E, B is the "base" and E is
the "exponent". I see you're using "exponent" already but it might
make sense to change "scale" to "base" throughout this series.

> +
> +       struct kvm_stats_desc {
> +               __u32 flags;
> +               __s16 exponent;
> +               __u16 size;
> +               __u32 unused1;
> +               __u32 unused2;
> +               char name[0];
> +       };
> +
> +The ``flags`` field contains the type and unit of the statistics data described
> +by this descriptor. The following flags are supported:

nit: Suggest breaking this list out into separate lists so readers can
differentiate between the type, unit, and scale. Something like:

Bits 0-3 of ``flags`` encode the type:

* ``KVM_STATS_TYPE_CUMULATIVE`` ...
* ``KVM_STATS_TYPE_INSTANT`` ...

Bits 4-7 of ``flags encode the unit:

* ``KVM_STATS_UNIT_NONE`` ...
...
etc.

> +  * ``KVM_STATS_TYPE_CUMULATIVE``
> +    The statistics data is cumulative. The value of data can only be increased.
> +    Most of the counters used in KVM are of this type.
> +    The corresponding ``count`` filed for this type is always 1.
> +  * ``KVM_STATS_TYPE_INSTANT``
> +    The statistics data is instantaneous. Its value can be increased or
> +    decreased. This type is usually used as a measurement of some resources,
> +    like the number of dirty pages, the number of large pages, etc.
> +    The corresponding ``count`` field for this type is always 1.
> +  * ``KVM_STATS_UNIT_NONE``
> +    There is no unit for the value of statistics data. This usually means that
> +    the value is a simple counter of an event.
> +  * ``KVM_STATS_UNIT_BYTES``
> +    It indicates that the statistics data is used to measure memory size, in the
> +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> +    determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_SCALE_POW2`` flag is valid in this case. The unit of the data is
> +    determined by ``pow(2, exponent)``. For example, if value is 10,
> +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> +    can get the statistics data in the unit of Byte by
> +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> +    10 * 1024 * 1024 Bytes.
> +  * ``KVM_STATS_UNIT_SECONDS``
> +    It indicates that the statistics data is used to measure time/latency, in
> +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> +    data is determined by the ``exponent`` field in the descriptor. The
> +    ``KVM_STATS_SCALE_POW10`` flag is valid in this case. The unit of the data
> +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> +    we can get the statistics data in the unit of second by
> +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> +  * ``KVM_STATS_UNIT_CYCLES``
> +    It indicates that the statistics data is used to measure CPU clock cycles.
> +    The ``KVM_STATS_SCALE_POW10`` flag is valid in this case. For example, if
> +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> +
> +The ``exponent`` field is the scale of corresponding statistics data. It has two
> +values as follows:
> +  * ``KVM_STATS_SCALE_POW10``

I thought the scale was encoded in ``flags`` not ``exponent``? Isn't
the exponent the

> +    The scale is based on power of 10. It is used for measurement of time and
> +    CPU clock cycles.
> +  * ``KVM_STATS_SCALE_POW2``
> +    The scale is based on power of 2. It is used for measurement of memory size.

It might be useful to give an example of how to use the exponent field
in practice.

> +
> +The ``size`` field is the number of values of this statistics data. It is in the
> +unit of ``unsigned long`` for VCPU or ``__u64`` for VM.
> +
> +The ``unused1`` and ``unused2`` fields are reserved for future
> +support for other types of statistics data, like log/linear histogram.
> +
> +The ``name`` field points to the name string of the statistics data. The name
> +string starts at the end of ``struct kvm_stats_desc``.
> +The maximum length (including trailing '\0') is indicated by ``name_size``
> +in ``struct kvm_stats_header``.
> +
> +The Stats Data block contains an array of data values of type ``struct
> +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
> +user space periodically to pull statistics data.
> +The order of data value in Stats Data block is the same as the order of
> +descriptors in Descriptors block.
> +  * Statistics data for VM::
> +
> +       struct kvm_vm_stats_data {
> +               unsigned long value[0];
> +       };
> +
> +  * Statistics data for VCPU::
> +
> +       struct kvm_vcpu_stats_data {
> +               __u64 value[0];
> +       };
> +
>  5. The kvm_run structure
>  ========================
>
> @@ -6891,3 +7054,11 @@ This capability is always enabled.
>  This capability indicates that the KVM virtual PTP service is
>  supported in the host. A VMM can check whether the service is
>  available to the guest on migration.
> +
> +8.33 KVM_CAP_STATS_BINARY_FD
> +----------------------------
> +
> +:Architectures: all
> +
> +This capability indicates the feature that user space can create get a file
> +descriptor for every VM and VCPU to read statistics data in binary format.
> --
> 2.31.1.751.gd2f1c929bd-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
