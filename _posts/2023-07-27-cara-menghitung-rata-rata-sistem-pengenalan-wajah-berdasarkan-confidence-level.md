---
layout: post
title: Cara Menghitung Akurasi Rata-Rata Sistem Pengenalan Wajah Berdasarkan Confidence Level
modified: 2023-07-27T17:00:28+07:00
categories:
description: "Cara Menghitung Akurasi Rata-Rata Sistem Pengenalan Wajah Berdasarkan Confidence Level"
tags: [ai, ml]
image:
  background: triangular.png
comments: true
share: true
published: true
date: 2023-07-27T17:00:28+07:00
---

Untuk menghitung akurasi rata-rata pengenalan wajah berdasarkan tingkat kepercayaan (confidence level), Anda perlu memahami bagaimana sistem pengenalan wajah mengeluarkan nilai kepercayaan (confidence score) saat mengenali wajah. Confidence score adalah nilai yang menunjukkan seberapa yakin sistem dalam pengenalan wajah.

Langkah-langkah untuk menghitung akurasi rata-rata berdasarkan tingkat kepercayaan adalah sebagai berikut:

1. Atur threshold kepercayaan: Pertama, tentukan threshold atau ambang batas kepercayaan tertentu. Threshold ini digunakan untuk memutuskan apakah wajah dianggap benar dikenali atau tidak. Misalnya, jika confidence score dari suatu wajah lebih besar dari threshold, maka wajah tersebut dianggap dikenali; jika tidak, maka wajah dianggap tidak dikenali.
1. Bagi data Anda menjadi dua bagian: data pelatihan dan data uji.
1. Latih sistem pengenalan wajah menggunakan data pelatihan.
1. Gunakan model yang dilatih untuk mengenali wajah pada data uji dan peroleh confidence score untuk setiap wajah.
1. Hitung TP (True Positive), TN (True Negative), FP (False Positive), dan FN (False Negative) berdasarkan hasil pengenalan wajah dan threshold kepercayaan yang telah ditentukan.
1. Hitung metrik evaluasi berikut berdasarkan nilai TP, TN, FP, dan FN:
  - Akurasi: (TP + TN) / (TP + TN + FP + FN)
  - Presisi: TP / (TP + FP)
  - Recall: TP / (TP + FN)
  - F1-Score: 2 * (Presisi * Recall) / (Presisi + Recall)
1. Lakukan proses 3-6 dengan mengubah threshold kepercayaan menjadi nilai lain, misalnya dengan menggunakan rentang nilai confidence score tertentu atau melakukan iterasi dengan nilai yang berbeda.
1. Ambil rata-rata nilai-nilai metrik evaluasi dari beberapa pengujian dengan threshold kepercayaan yang berbeda untuk mendapatkan akurasi rata-rata pengenalan wajah berdasarkan tingkat kepercayaan.

Dengan pendekatan ini, Anda dapat mengevaluasi bagaimana akurasi pengenalan wajah berubah dengan perubahan threshold kepercayaan. Perhatikan bahwa pilihan threshold kepercayaan yang tepat harus mempertimbangkan keseimbangan antara akurasi dan jumlah wajah yang diidentifikasi dengan benar (recall) serta wajah yang salah diidentifikasi sebagai benar (precision).